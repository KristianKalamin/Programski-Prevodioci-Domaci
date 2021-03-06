%{
    #include <stdio.h>
    #define YYSTYPE char*
    int yylex(void);
    int yyparse(void);
    int yyerror(char *s);
    extern int yylineno;
    int broj_pasusa=0;
%}

%token _NEWLINE
%token _WORD
%token _DOT
%token _CAPITAL_WORD

%%

pasus
    : 
    | pasus _CAPITAL_WORD e _NEWLINE {broj_pasusa++;}
    ;
e
    :
    | _WORD e
    | _CAPITAL_WORD e
    | _DOT e
    ;


%%

int main()
{
    yyparse();
    printf("Broj pasusa je: %d\n",broj_pasusa);
    return 0;
}

int yyerror(char *s)
{
	fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
}
