bison -d zad2.y
flex zad2.l
gcc -o zad2 zad2.tab.c lex.yy.c
./zad2 < test.txt