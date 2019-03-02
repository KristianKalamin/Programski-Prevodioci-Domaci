flex --noyywrap temp.l
gcc -o temp lex.yy.c -l l
./temp < test.txt