%option noyywrap 

%{
    #define YYSTYPE char*
    #include "zad5.tab.h"
%}


%%
(c|C)olor {return _COLOR;}
(a|A)m {return _AM;}
(f|F)all { return _FALL;}
(c|C)ookie { return _COOKIE;}
(f|F)ries { return _FRIES;}
(f|F)reeway { return _FREEWAY;}



