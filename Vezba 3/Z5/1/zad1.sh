bison -d zad1.y
flex zad1.l
gcc -o zad1 zad1.tab.c lex.yy.c
./zad1 < test.txt