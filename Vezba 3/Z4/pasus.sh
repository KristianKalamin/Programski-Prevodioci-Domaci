bison -d pasus.y
flex pasus.l
gcc -o pasus pasus.tab.c lex.yy.c
./pasus < test.txt