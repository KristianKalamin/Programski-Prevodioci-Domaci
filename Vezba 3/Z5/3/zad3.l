%option noyywrap 

%{
    #include "zad3.tab.h"
%}


%%
[ \t/]+
[0-9]{2,2} {yylval = atoi(yytext); return _DATE;}
[0-9]{4,4} {yylval = atoi(yytext); return _YEAR;}

(\n) {return _NEWLINE;}
.	{printf("Unknown char: %c\n", *yytext);}


