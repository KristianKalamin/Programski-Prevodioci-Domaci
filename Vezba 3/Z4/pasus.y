%{
    #include <stdio.h>
    #define YYSTPE char*
    int yylex(void);
    int yyparse(void);
    int yyerror(char *s);
    extern int yylineno;
    int broj_pasusa=0;
%}

%token _NEWLINE
%token _PASUS

%%

pasus
    : /*empty text*/
    | pasus _PASUS  {broj_pasusa++;} 
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
