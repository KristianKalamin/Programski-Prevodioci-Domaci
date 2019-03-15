bison -d zad3.y
flex zad3.l
gcc -o zad3 zad3.tab.c lex.yy.c
./zad3 < test.txt