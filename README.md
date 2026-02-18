# Validador de Números Complejos con Flex
## Miguel Ángel Celis López
## Joaquin Fernando Sanchez
## Universidad Sergio Arboleda
## Lenguajes de Programación

##  Descripción

Este programa fue desarrollado utilizando Flex (Fast Lexical Analyzer Generator) para validar números complejos de la forma:

a + b

Donde:

- a pertenece a los números reales.
- b pertenece a los números reales o puede ser únicamente la unidad imaginaria.
- La unidad imaginaria permitida es: i, I, j, J.
- El operador permitido es únicamente el signo "+".

El programa recibe como entrada un archivo de texto (.txt) y evalúa cada línea del archivo, indicando si la expresión corresponde a un número complejo válido o no.

---

##  Estructura del Analizador

Se definieron las siguientes expresiones regulares:

- DIGITO      → [0-9]
- REAL        → [-+]?{DIGITO}+(\.{DIGITO}+)?
- ESPACIO     → [\t ]*
- UNIDAD      → [iIjJ]
- IMAGINARIO  → ({REAL}{UNIDAD}|{UNIDAD})
- COMPLEJO    → {REAL}{ESPACIO}\+{ESPACIO}{IMAGINARIO}

La estructura válida es:

REAL + IMAGINARIO

Esto permite:

- Parte real con signo opcional.
- Parte imaginaria con número explícito o solo la unidad.
- Espacios opcionales alrededor del operador "+".

---

## Archivos del Proyecto

nComplejos.l  → Código fuente en Flex  
test.txt      → Archivo de pruebas  
README.md     → Documentación del proyecto  

---

## Compilación

Para compilar en Linux (Ubuntu, Fedora, etc.):

flex nComplejos.l  

gcc lex.yy.c -o validador -lfl  


Esto genera el ejecutable:

validador

---

## Ejecución

./validador test.txt

---

## Archivo de Prueba (test.txt)

Contenido utilizado:

3.5+2i  
3.5e-10  
4+I  
-3.5+2j  
10-5J  
+7.2+3.1i  
hello  
42  
0.5i  
3.5 + 2i  
3.5 e -10  
4 + I  
I  
i  
J  
j  
5.5 + j  
-2.5 + 3i  

---


## Código Fuente: 
```bash
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

```

## Salida Obtenida

ACEPTADO: 3.5+2i  
NO ACEPTADO: 3.5e-10  
ACEPTADO: 4+I  
ACEPTADO: -3.5+2j  
NO ACEPTADO: 10-5J  
ACEPTADO: +7.2+3.1i  
NO ACEPTADO: hello  
NO ACEPTADO: 42  
NO ACEPTADO: 0.5i  
ACEPTADO: 3.5 + 2i  
NO ACEPTADO: 3.5 e -10  
ACEPTADO: 4 + I  
NO ACEPTADO: I  
NO ACEPTADO: i  
NO ACEPTADO: J  
NO ACEPTADO: j  
ACEPTADO: 5.5 + j  

---

## Casos Aceptados

- Parte real con signo opcional.
- Parte imaginaria con número o solo unidad.
- Espacios opcionales alrededor del operador.
- Letras i, I, j, J como unidad imaginaria.

---

##  Casos No Aceptados

- Notación científica.
- Uso del operador "-".
- Solo unidad imaginaria.
- Texto no numérico.
- Solo número real.


# Conclusiones

1. Se implementó correctamente un analizador léxico en Flex capaz de validar números complejos de la forma a + b mediante el uso de expresiones regulares bien definidas.

2. El programa demuestra cómo las expresiones regulares pueden modelar formalmente un lenguaje específico y cómo Flex las convierte en un autómata finito determinista para reconocer cadenas válidas.

3. El uso de un archivo de entrada permite procesar múltiples casos de prueba de manera eficiente, diferenciando claramente entre expresiones aceptadas y no aceptadas según la estructura definida.
