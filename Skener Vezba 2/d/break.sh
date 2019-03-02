flex --noyywrap -i break_case.l
gcc -o break_case lex.yy.c -l l
./break_case < test.txt