%{
 #include "calc.tab.h"
 #include <stdlib.h>
 void yyerror(char *);
%}

%%

[0-9]+ { yylval = atoi(yytext); return NUMERO; }
-[0-9]+ { yylval = atoi(yytext); return NEG; }
[ \t] ;
"/" {return DIV;}
"=" {return IGUAL;}
"*" {return MUL;}
"+" {return MAS;}
"-" {return MIN;}
"(" {return ABREP;}
")" {return CIERRAP;}
"\n" {return ENTER;}
. yyerror("Caracter Invalido");

%%


int yywrap(void) {
 return 1;
}
