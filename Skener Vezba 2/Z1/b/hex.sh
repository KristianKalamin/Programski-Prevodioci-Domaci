flex --noyywrap hex.l
gcc -o hex lex.yy.c -l l
./hex < test.txt