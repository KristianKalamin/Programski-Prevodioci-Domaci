%{
    #include <stdio.h>
    #define YYSTYPE char*
    int yylex(void);
    int yyparse(void);
    int yyerror(char *s);
    extern int yylineno;
    int broj_recenica=0;
%}

%token _WORD
%token _DOT
%token _COMMA

%%

lines
    : /*empty*/
    | lines e _DOT {broj_recenica++;}
    | lines e _COMMA _DOT {printf("\nError! %d\n",yylineno);}
    ;
e
    : /*empty*/
    | e _COMMA _WORD
    | e _WORD
    ;
%%

int main()
{
    yyparse();
    printf("\nBroj recenica: %d\n",broj_recenica);
}

int yyerror(char *s)
{
    fprintf(stderr, "Line %d Error %s\n",yylineno,s);
}

