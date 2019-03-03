%{
    int F = 0;
    int C = 0;
%}
%%
[0-9]+F+ {   
            F = atoi(yytext);
            C = (F-32) * 5/9;
            printf("%dC", C);
            
            C = 0;
            F = 0;
        } 


