%{
    #include <stdio.h>
    #define YYSTYPE char*
    int yylex(void);
    int yyparse(void);
    int yyerror(char *s);
    extern int yylineno;
    int capital_word_num=0;
    int word_num=0;
%}

%token _CAPITAL_WORD
%token _WORD

%%
    word
        : /*empty text*/
        | word _CAPITAL_WORD {capital_word_num++;}
        | word _WORD {word_num++;}
        ;

%%
int main()
{
    yyparse();
    printf("Broj reci koje pocinju sa velikim slovom je: %d\n",capital_word_num);
    printf("Broj reci koje pocinju sa malim slovom je: %d\n",word_num);
    return 0;
}

int yyerror(char *s)
{
	fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
}