%{
    #include <ctype.h>
    #include <stdio.h>
    int yylex(void);
    int yyparse(void);
    int yyerror(char *s);
    int year = 0;
    char *months[] = {"", "January","February","March","April","May","June","July","August","September","October","November","December"};
    int i = 0;
    int dates[2];
%}

%token _DATE
%token _NEWLINE
%token _YEAR

%%
    date
        : /*empty text*/
        | date  e _NEWLINE {printf("%s %d, %d.",months[dates[1]],dates[0],year); i=0;}
        ;
    e
        : 
        | e _DATE { dates[i] = yylval; i++; }
        | e _YEAR { year = yylval;}
        ;
%%
int main()
{
    return yyparse();
}

int yyerror(char *s)
{
	fprintf(stderr, "%s\n",s);
}