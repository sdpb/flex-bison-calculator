%{

    #include <stdio.h>
    void yyerror(char *);
    int yylex(void);
    int vet[20];
    int registerCount = 0;
    int instructionCount = 1;
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
    expression  { printf("MOV R%d, *R%d ; Store content(R%d) into memory location contents(R%d)\n", registerCount, registerCount+1, registerCount, registerCount+1); registerCount++; instructionCount++; }
    | VARIABLE IGUAL expression { vet[$1] = $3; }
    ;
expression:
    NUMERO { printf("MOV #%d, R%d ; Store %d into R%d\n", $1, registerCount, $1, registerCount); $$ = $1; registerCount++; instructionCount++; }
    | NEG { printf("MOV #-%d, R%d ; Store -%d into R%d\n", $1, registerCount, $1, registerCount); $$ = -$1; registerCount++; instructionCount++; }
    | VARIABLE { printf("MOV M, R%d ; Store content(M) into R%d\n", registerCount, registerCount); $$ = vet[$1]; registerCount++; instructionCount++; }
    | expression MAS expression { printf("ADD R%d, R%d ; Add R%d to R%d\n", registerCount, registerCount+1, registerCount, registerCount+1); registerCount++; instructionCount++; $$ = $1 + $3; }
    | expression MIN expression { printf("SUB R%d, R%d ; Subtract R%d from R%d\n", registerCount, registerCount+1, registerCount, registerCount+1); registerCount++; instructionCount++; $$ = $1 - $3; }
    | expression MUL expression { printf("MUL R%d, R%d ; Multiply R%d by R%d\n", registerCount, registerCount+1, registerCount, registerCount+1); registerCount++; instructionCount++; $$ = $1 * $3; }
    | expression DIV expression { printf("DIV R%d, R%d ; Divide R%d by R%d\n", registerCount, registerCount+1, registerCount, registerCount+1); registerCount++; instructionCount++; $$ = $1 / $3; }
    | ABREP expression CIERRAP { printf("MOV INDIRECT R%d, R%d ; Store contents(R%d) into R%d\n", $2, registerCount, $2, registerCount); $$ = $2; registerCount++; instructionCount++; }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
    printf("\nTotal number of instructions: %d\n", instructionCount);
}

