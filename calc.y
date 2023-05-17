%{

    #include <stdio.h>
    void yyerror(char *);
    int yylex(void);
    int vet[20];
%}

%token NUMERO VARIABLE
%token ABREP CIERRAP MAS MIN MUL DIV IGUAL NEG ENTER
%left MAS MIN IGUAL
%left DIV MUL
%left NEG 

%%

program:
    program statement ENTER 
    | /* NULL */ 
    ;
statement:
    expression  { printf("\nResultado final: %d\n\n", $1); }
    | VARIABLE IGUAL expression { vet[$1] = $3; }
    ;
expression:
    NUMERO { printf("N %d\n", $1); }
    | NEG { printf("-N %d\n", $1); }
    | VARIABLE { printf("V %d\n", $1); $$ = vet[$1]; }
    | expression MAS expression { printf("M+ %d\n", $1 + $3); $$ = $1 + $3; }
    | expression MIN expression { printf("M- %d\n", $1 - $3); $$ = $1 - $3; }
    | expression MUL expression { printf("M* %d\n", $1 * $3); $$ = $1 * $3; }
    | expression DIV expression { printf("D/ %d\n", $1 / $3); $$ = $1 / $3; }
    | ABREP expression CIERRAP { printf("() %d\n", $2); $$ = $2; }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
}


