%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "defs.h"
  #include "symbol.tab.h"
  #include "codegen.h"

  int yyparse(void);
  int yylex(void);
  int yyerror(char *s);
  void warning(char *s);

  extern int yylineno;
  int out_lin = 0;
  char char_buffer[CHAR_BUFFER_LENGTH];
  int error_count = 0;
  int warning_count = 0;
  int var_num = 0;
  int fun_idx = -1;
  int fcall_idx = -1;
  int lab_num = -1;
  FILE *output;

  int switch_expression_idx = 0;
  int case_const[10];
  int i = 0;

  int switchCount = 0;
  bool breakOK = FALSE;
%}

%union {
  int i;
  char *s;
}

%token <i> _TYPE
%token _IF
%token _ELSE
%token _RETURN
%token <s> _ID
%token <s> _INT_NUMBER
%token <s> _UINT_NUMBER
%token _LPAREN
%token _RPAREN
%token _LBRACKET
%token _RBRACKET
%token _ASSIGN
%token _SEMICOLON
%token <i> _AROP
%token <i> _RELOP

%token _SWITCH
%token _CASE
%token _BREAK
%token _DEFAULT
%token _COLON

%type <i> type num_exp exp literal parameter
%type <i> function_call argument rel_exp if_part

%nonassoc ONLY_IF
%nonassoc _ELSE

%%

program
  : global_list function_list
      {  
        int idx = lookup_symbol("main", FUN);
        if(idx == -1)
          err("undefined reference to 'main'");
        else 
          if(get_type(idx) != INT)
            warn("return type of 'main' is not int");
      }
  ;

global_list
  : /* empty */
  | global_list global_var
  ; 

global_var
  : type _ID _SEMICOLON
      { 
        insert_symbol($2, GVAR, $1, NO_ATR, NO_ATR);
        code("\n%s:\n\t\t\tWORD\t1", $2);
      }
  ;

function_list
  : function
  | function_list function
  ;

function
  : type _ID
      {
        fun_idx = lookup_symbol($2, FUN);
        if(fun_idx == -1)
          fun_idx = insert_symbol($2, FUN, $1, NO_ATR, NO_ATR);
        else 
          err("redefinition of function '%s'", $2);

        code("\n%s:", $2);
        code("\n\t\t\tPUSH\t%%14");
        code("\n\t\t\tMOV \t%%15,%%14");
      }
    _LPAREN parameter _RPAREN
      {
        set_atr1(fun_idx, $5);
        var_num = 0;
      }
    body
      {
        clear_symbols(fun_idx + 1);

        gen_sslab($2,"_exit");
        code("\n\t\t\tMOV \t%%14,%%15");
        code("\n\t\t\tPOP \t%%14");
        code("\n\t\t\tRET");
      }
  ;

type
  : _TYPE
      {  $$ = $1; }
  ;

parameter
  : /* empty */
      { $$ = 0; }

  | type _ID
      {
        insert_symbol($2, PAR, $1, 1, NO_ATR);
        set_atr2(fun_idx, $1);
        $$ = 1;
      }
  ;

body
  : _LBRACKET variable_list
      {
        if(var_num)
          code("\n\t\t\tSUBS\t%%15,$%d,%%15", 4*var_num);
        gen_sslab(get_name(fun_idx), "_body");
      }
    statement_list _RBRACKET
  ;

variable_list
  : /* empty */
  | variable_list variable
  ;

variable
  : type _ID _SEMICOLON
      {
        if(lookup_symbol($2, VAR|PAR) == -1)
           insert_symbol($2, VAR, $1, ++var_num, NO_ATR);
        else 
           err("redefinition of '%s'", $2);
      }
  ;

statement_list
  : /* empty */
  | statement_list statement
  ;

statement
  : compound_statement
  | assignment_statement
  | if_statement
  | return_statement
  | switch_statement
  ;

switch_statement
  : _SWITCH _LPAREN _ID
    {
      switch_expression_idx = lookup_symbol($3, VAR|PAR);
      if(switch_expression_idx == -1)
        err("%s not declared",$3);

      switchCount++;
      breakOK = TRUE;
      gen_snlab("switch",switchCount);
      code("\n\t\t\tJMP\t\t@test%d", switchCount);
    }
  _RPAREN _LBRACKET cases default_statement _RBRACKET 
    {
      int idx = lookup_symbol($3, (VAR|PAR|GVAR));
      gen_snlab("test",switchCount);
      int j;
      for(j = 0; j < i; j++) {
        gen_cmp(idx, case_const[j]);
        code("\n\t\t\tJEQ\t\t@case%d",j+1);
      }
      code("\n\t\t\tJMP\t\t@default%d", switchCount);
      gen_snlab("switch_exit",switchCount);
      breakOK = FALSE;
      i = 0;
    }
  ;

default_statement
  :
  | _DEFAULT _COLON 
    {
      gen_snlab("default",switchCount);
    } 
    statement
    {
      code("\n\t\t\tJMP\t\t@switch_exit%d", switchCount);
    } 
  ;

cases
  : case 
  | cases case 
  ;

case
  : _CASE literal _COLON
    {
      int j,x;
      char *lit = get_name($2);
      case_const[i] = $2;
      for(j = 0, x = 0; j < i;j++)
      {
        if(case_const[j] == $2)
        {
          x++;
        }
      }
      i++;
      if(x > 0)
        err("constant must be unique");
      
      int l = get_type($2);
      int si = get_type(switch_expression_idx);
      if(l != si)
        err("case not same type as switch expresion");
      
      code("\n@case%d:\t\t", i);
    }
   statement break_statement
    
  ;

break_statement
  :
  | _BREAK _SEMICOLON
    {
      if(breakOK != TRUE)
        err("ERROR 'break' must be in switch");

      code("\n\t\t\tJMP\t\t@switch_exit%d", switchCount);
    }
  ;

compound_statement
  : _LBRACKET statement_list _RBRACKET
  ;

assignment_statement
  : _ID _ASSIGN num_exp _SEMICOLON
      {
        int idx = lookup_symbol($1, (VAR|PAR|GVAR));
        if(idx == -1)
          err("invalid lvalue '%s' in assignment", $1);
        else
          if(get_type(idx) != get_type($3))
            err("incompatible types in assignment");
        gen_mov($3, idx);
      }
  ;

num_exp
  : exp
  | num_exp _AROP exp
      {
        if(get_type($1) != get_type($3))
          err("invalid operands: arithmetic operation");
        int t1 = get_type($1);
        code("\n\t\t\t%s\t", get_arop_stmt($2, t1));
        print_symbol($1);
        code(",");
        print_symbol($3);
        code(",");
        if($3 >= 0 && $3 <= LAST_WORKING_REG)
          free_reg();
        if($1 >= 0 && $1 <= LAST_WORKING_REG)
          free_reg();
        $$ = take_reg();
        print_symbol($$);
        set_type($$, t1);
      }
  ;

exp
  : literal
  | _ID
      {
        $$ = lookup_symbol($1, (VAR|PAR|GVAR));
        if($$ == -1)
          err("'%s' undeclared", $1);
      }
  | function_call
      {
        $$ = take_reg();
        gen_mov(FUN_REG, $$);
      }
  | _LPAREN num_exp _RPAREN
      { $$ = $2; }
  ;

literal
  : _INT_NUMBER
      { $$ = insert_literal($1, INT); }

  | _UINT_NUMBER
      { $$ = insert_literal($1, UINT); }
  ;

function_call
  : _ID 
      {
        fcall_idx = lookup_symbol($1, FUN);
        if(fcall_idx == -1)
          err("'%s' is not a function", $1);
      }
    _LPAREN argument _RPAREN
      {
        if(get_atr1(fcall_idx) != $4)
          err("wrong number of arguments");
        code("\n\t\t\tCALL\t%s", get_name(fcall_idx));
        if($4 > 0)
          code("\n\t\t\tADDS\t%%15,$%d,%%15", $4 * 4);
        set_type(FUN_REG, get_type(fcall_idx));
        $$ = FUN_REG;
      }
  ;

argument
  : /* empty */
    { $$ = 0; }

  | num_exp
    { 
      if(get_atr2(fcall_idx) != get_type($1))
        err("incompatible type for argument");
      free_if_reg($1);
      code("\n\t\t\tPUSH\t");
      print_symbol($1);
      $$ = 1;
    }
  ;

if_statement
  : if_part %prec ONLY_IF
      { gen_snlab("exit", $1); }

  | if_part _ELSE statement
      { gen_snlab("exit", $1);}
  ;

if_part
  : _IF _LPAREN
      {
        $<i>$ = ++lab_num;
        gen_snlab("if", lab_num);
      }
    rel_exp
      {
        code("\n\t\t\t%s\t@false%d", 
          get_jump_stmt($4, TRUE),$<i>3);
        gen_snlab("true", $<i>3);
      }
    _RPAREN statement
      {
        code("\n\t\t\tJMP \t@exit%d", $<i>3);
        gen_snlab("false", $<i>3);
        $$ = $<i>3;
      }
  ;

rel_exp
  : num_exp _RELOP num_exp
      {
        if(get_type($1) != get_type($3))
          err("invalid operands: relational operator");
        $$ = $2 + ((get_type($1) - 1) * RELOP_NUMBER);
        gen_cmp($1, $3);
      }
  ;

return_statement
  : _RETURN num_exp _SEMICOLON
      {
        if(get_type(fun_idx) != get_type($2))
          err("incompatible types in return");
        gen_mov($2, FUN_REG);
        code("\n\t\t\tJMP \t@%s_exit", get_name(fun_idx));        
      }
  ;

%%

int yyerror(char *s) {
  fprintf(stderr, "\nline %d: ERROR: %s", yylineno, s);
  error_count++;
  return 0;
}

void warning(char *s) {
  fprintf(stderr, "\nline %d: WARNING: %s", yylineno, s);
  warning_count++;
}

int main() {
  int synerr;
  init_symtab();
  output = fopen("program.asm", "w+");

  synerr = yyparse();

  clear_symtab();
  fclose(output);
  
  if(warning_count)
    printf("\n%d warning(s).\n", warning_count);

  if(error_count) {
    remove("program.asm");
    printf("\n%d error(s).\n", error_count);
  }

  if(synerr)
    return -1;
  else
    return error_count;
}


