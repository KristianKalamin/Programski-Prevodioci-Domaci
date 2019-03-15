%option noyywrap yylineno

%{
    #define YYSTYPE char*
    #include "zad1.tab.h"
%}

%%
[ \n\t.,]+ {}
[A-Z][a-z]* {return _CAPITAL_WORD;}
[a-z]+ {return _WORD;}
. {printf("\n line %d LEXICAL ERROR %s",yylineno, yytext);}


