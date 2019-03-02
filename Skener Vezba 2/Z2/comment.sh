flex --noyywrap comment.l
gcc -o comment lex.yy.c -l l
./comment < test.txt