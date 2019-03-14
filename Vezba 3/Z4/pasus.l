%option noyywrap yylineno

%{
    #define YYSTYPE char*
    #include "pasus.tab.h"
%}

%%
[a-zA-z.,\t ]+(\n) { return _PASUS; }

