%option noyywrap yylineno

%{
    #define YYSTYPE char*
    #include "zad2.tab.h"
%}

%%
[ \n\t]+ 
[A-Za-z]* {;yylval = yytext; return _WORD;}
"." {return _DOT;}
. {printf("\n line %d LEXICAL ERROR %s",yylineno, yytext);}


