bison -d recenica.y
flex recenica.l
gcc -o recenica recenica.tab.c lex.yy.c
./recenica < test.txt
