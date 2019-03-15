%{
    #include <ctype.h>
    #include <stdio.h>
    int yylex(void);
    int yyparse(void);
    int yyerror(char *s);
    int hours = 0;
    int minutes = 0;
    int pm = 0;
%}

%token _NUMBER
%token _DOT
%token _NEWLINE

%%
    time
        : /*empty text*/
        | time  e _NEWLINE {
                            if(pm)
                                printf("%d:%d PM\n",hours,minutes);
                            else
                                printf("%d:%d AM\n",hours,minutes);
                            pm = 0;
                            }
        ;
    e
        : 
        | e _NUMBER _DOT {
                            hours = yylval;
                            if(hours > 12)
                            {
                                hours-=12;
                                pm = 1;
                            }

                        }
        | e _NUMBER {
                        minutes = yylval;
                    }
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