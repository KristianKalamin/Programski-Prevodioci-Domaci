%option noyywrap yylineno

%{
    #include "zarez.tab.h"
%}

%%
[ \t\n]+ {}
"." {return _DOT;}
"," {return _COMMA;}
[a-zA-Z]+	{return _WORD;}
. {printf("\nline %d LEXICAL ERROR on %c", yylineno, *yytext);}

