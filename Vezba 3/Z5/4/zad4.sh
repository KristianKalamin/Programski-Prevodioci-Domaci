bison -d zad4.y
flex zad4.l
gcc -o zad4 zad4.tab.c lex.yy.c
./zad4 < test.txt