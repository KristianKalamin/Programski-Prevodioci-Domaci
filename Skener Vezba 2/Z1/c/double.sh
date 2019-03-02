flex --noyywrap double.l
gcc -o double lex.yy.c -l l
./double < test.txt