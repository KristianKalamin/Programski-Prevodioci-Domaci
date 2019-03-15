bison -d zad5.y
flex zad5.l
gcc -o zad5 zad5.tab.c lex.yy.c
./zad5 < test.txt