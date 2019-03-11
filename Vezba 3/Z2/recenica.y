%{
	#include <stdio.h>
	#define YYSTYPE char*
	int yylex(void);
	int yyparse(void);
	int yyerror(char *s);
	extern int yylineno;
	int word_counter=0;
	int sentence_counter=0;
	int question_counter=0;
	int exclamation_counter=0;
%}

%token _DOT
%token _CAPITAL_WORD
%token _WORD
%token _QUESTION_MARK
%token _EXCLAMATION_MARK
%%

text	
	: /*empty text*/
	| text sentence 
	| text question 
	| text exclamation
	;
sentence
	: _CAPITAL_WORD words _DOT {sentence_counter++;}
	;
question
	: _CAPITAL_WORD words _QUESTION_MARK {question_counter++;}
	;
exclamation
	: _CAPITAL_WORD words _EXCLAMATION_MARK {exclamation_counter++;}
	;

words
	: /*empty*/
	| words _WORD {}
	| words _CAPITAL_WORD {}
	;
%%

int main()
{
	yyparse();
	printf("Broj upitnih recenica %d\n",question_counter);
	printf("Broj uzvicnih recenica %d\n", exclamation_counter);
	printf("Broj izjavnih recenica %d\n", sentence_counter);
}

int yyerror(char *s)
{
	fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
}
