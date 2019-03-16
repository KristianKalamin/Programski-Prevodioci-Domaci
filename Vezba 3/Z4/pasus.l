%option noyywrap yylineno

%{
    #define YYSTYPE char*
    #include "pasus.tab.h"
%}

%%
[ \t,] 
"." {return _DOT;}
[A-Z][a-z]*	{ return _CAPITAL_WORD;}
[a-z]+		{ return _WORD;}
(\n)+ { return _NEWLINE;}
