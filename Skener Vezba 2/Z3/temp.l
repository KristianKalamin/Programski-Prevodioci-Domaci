%{
    int F = 0;
    int C = 0;
    int i = 0;
    char a[3];
%}
%%
[0-9]+F+ {   while(yytext[i] != 'F')
               {
                   a[i] = yytext[i]; 
                   i++;
               }
            i++;
            a[i] = '\n';
            sscanf(a, "%d", &F);
            C = (F-32) * 5/9;
            printf("%dC", C);

            i = 0;
            C = 0;
            F = 0;
        } 


