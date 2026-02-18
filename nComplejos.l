%{
#include <stdio.h>
%}


DIGITO      [0-9]
REAL        [-+]?{DIGITO}+(\.{DIGITO}+)?
ESPACIO     [\t ]*
UNIDAD      [iIjJ]
IMAGINARIO  ({REAL}{UNIDAD}|{UNIDAD})
COMPLEJO    {REAL}{ESPACIO}\+{ESPACIO}{IMAGINARIO}

%%

{COMPLEJO}  { printf("ACEPTADO: %s\n", yytext); }

\n          { }

.+          { printf("NO ACEPTADO: %s\n", yytext); }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error al abrir el archivo");
            return 1;
        }
    } else {
        printf("Uso: ./programa test.txt\n");
        return 1;
    }

    yylex();
    
    fclose(yyin);
    return 0;
}

int yywrap() {
    return 1;
}