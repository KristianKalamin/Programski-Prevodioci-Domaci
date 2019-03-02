%x COMMENT

%%
"/*" { BEGIN COMMENT;}
<COMMENT>.|\n {/* preskace tekst komentara */}
<COMMENT>"*/"   {BEGIN INITIAL;}

"//".*


