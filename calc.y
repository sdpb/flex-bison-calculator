%{

    #include <stdio.h>
    void yyerror(char *);
    int yylex(void);
%}

%token NUMERO
%token ABREP CIERRAP MAS MIN MUL DIV IGUAL NEG ENTER
%left MAS MIN IGUAL
%left DIV MUL
%left NEG

%%

program:
    program statement ENTER { printf("Ingresa una expresion\n"); }
    | /* NULL */ { printf("Ingresa una expresion \n"); }
    ;
statement:
    expression  { printf("\nResultado final: %d\n\n", $1); }
    ;
expression:
    NUMERO { printf("LOAD %d\n", $1); }
    | NEG { printf("LOAD %d\n", $1); }
    | expression MAS expression { printf("ADD\t\t%d\n", $1 + $3); $$ = $1 + $3; }
    | expression MIN expression { printf("MIN\t\t%d\n", $1 - $3); $$ = $1 - $3; }
    | expression MUL expression { printf("MUL\t\t%d\n", $1 * $3); $$ = $1 * $3; }
    | expression DIV expression { printf("DIV\t\t%d\n", $1 / $3); $$ = $1 / $3; }
    | ABREP expression CIERRAP { printf("PARENTESIS\t%d\n", $2); $$ = $2; }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
}


