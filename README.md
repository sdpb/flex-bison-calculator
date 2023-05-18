# Bison and Yacc Calculator with code generation

## Instrucciones de compilación en Linux:

```
bison -d calc.y && flex calc.l
gcc -o calc.x calc.tab.c lex.yy.c
./calc.x
```
