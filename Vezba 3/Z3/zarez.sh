bison -d zarez.y
flex zarez.l
gcc -o zarez zarez.tab.c lex.yy.c
./zarez < test.txt
