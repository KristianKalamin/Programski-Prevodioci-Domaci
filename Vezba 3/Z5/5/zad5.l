%option noyywrap 

%{
    #define YYSTYPE char*
    #include "zad5.tab.h"
%}


%%
color {return _COLOR;}
am {return _AM;}
fall { return _FALL;}
cookie { return _COOKIE;}
fries { return _FRIES;}
freeway { return _FREEWAY;}



