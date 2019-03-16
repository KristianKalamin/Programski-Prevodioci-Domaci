%{
    #include <stdio.h>
    #include <ctype.h>
    #define YYSTYPE char*
    int yylex(void);
    int yyparse(void);
    int yyerror(char *s);
    extern int yylineno;
    int i = 1;
%}

%token _WORD
%token _DOT

%%
    word
        : 
        | word _WORD n
        ;
  
    n
        :
        | n _DOT x
        ;
    x
        :
        | _WORD {printf("%c",toupper(yylval[0]));
                    while(yylval[i] != 0){
                    printf("%c", yylval[i]);
                    i++;}
                    i=1;
                    printf("\n");}
        ;
   
%%
int main()
{
    yyparse();
    return 0;
}

int yyerror(char *s)
{
	fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
}