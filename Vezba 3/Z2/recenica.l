%option noyywrap yylineno

%{
	#define YYSTYPE char*
	#include "recenica.tab.h"
%}

%%
[ \t\n] 	{/*skip*/}
"."		{return _DOT;}
"?"		{return _QUESTION_MARK;}
"!"		{return _EXCLAMATION_MARK;}
[A-Z][a-z]*	{yylval = yytext; return _CAPITAL_WORD;}
[a-z]+		{yylval = yytext; return _WORD;}
.		{printf("\nline %d: LEXICAL ERROR on %c", yylineno, *yytext);}


