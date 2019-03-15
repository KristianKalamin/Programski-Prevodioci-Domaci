%option noyywrap 

%{
    #include "zad4.tab.h"
%}


%%
[ \t]+ {}
[0-9]+ {yylval = atoi(yytext); return _NUMBER;}
: {return _DOT;}
(\n) {return _NEWLINE;}
.	{printf("Unknown char: %c\n", *yytext);}


