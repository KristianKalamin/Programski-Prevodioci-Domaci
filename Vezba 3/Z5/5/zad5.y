%{
    #include <ctype.h>
    #include <stdio.h>
    #define YYSTYPE char*
    int yylex(void);
    int yyparse(void);
    int yyerror(char *s);
%}

%token _COLOR
%token _AM
%token _FALL
%token _COOKIE
%token _FRIES
%token _FREEWAY

%%
    word
        : /*empty text*/
        | word _COLOR {printf("colour");}
        | word _AM {printf("br");}
        | word _FALL {printf("autumn");}
        | word _COOKIE {printf("biscuit");}
        | word _FRIES {printf("chips");}
        | word _FREEWAY {printf("motorway");}
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