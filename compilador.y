
// Testar se funciona corretamente o empilhamento de par�metros
// passados por valor ou por refer�ncia.


%{
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include "compilador.h"
#include "stack.h"

int num_vars;

%}

%token PROGRAM ABRE_PARENTESES FECHA_PARENTESES
%token VIRGULA PONTO_E_VIRGULA DOIS_PONTOS PONTO
%token T_BEGIN T_END VAR IDENT ATRIBUICAO LABEL TYPE ARRAY OF PROCEDURE FUNCTION GOTO IF THEN ELSE WHILE DO DIV AND NOT MAIS MENOS VEZES DIVIDIDO IGUAL MENOR MAIOR

%%

programa    :{
             geraCodigo (NULL, "INPP");
             }
             PROGRAM IDENT
             ABRE_PARENTESES lista_idents FECHA_PARENTESES PONTO_E_VIRGULA
             bloco PONTO {
             geraCodigo (NULL, "PARA");
             }
;

bloco       :
              parte_declara_vars
              {
              }

              comando_composto
              ;




parte_declara_vars:  var
;


var         : { } VAR declara_vars
            |
;

declara_vars: declara_vars declara_var
            | declara_var
;

declara_var : { }
              lista_id_var DOIS_PONTOS
              tipo
              { 
                char str[10];
                sprintf(str, "AMEM %d", num_vars);
                geraCodigo (NULL, str);
                num_vars=0;
              }
              PONTO_E_VIRGULA
;

tipo        : IDENT
;

lista_id_var: lista_id_var VIRGULA IDENT
              { num_vars++; }
            | IDENT { num_vars++; }
;

lista_idents: lista_idents VIRGULA IDENT
            | IDENT
;


comando_composto: T_BEGIN comandos T_END

comandos: comando_sem_rotulo
;

comando_sem_rotulo: atribuicao
;

atribuicao: IDENT ATRIBUICAO expressao PONTO_E_VIRGULA
;

expressao: termo
;

%%

int main (int argc, char** argv) {
   FILE* fp;
   extern FILE* yyin;
   Stack *p = stackCreate(1024);

   if (argc<2 || argc>2) {
         printf("usage compilador <arq>a %d\n", argc);
         return(-1);
      }

   fp=fopen (argv[1], "r");
   if (fp == NULL) {
      printf("usage compilador <arq>b\n");
      return(-1);
   }


/* -------------------------------------------------------------------
 *  Inicia a Tabela de S�mbolos
 * ------------------------------------------------------------------- */

   yyin=fp;
   yyparse();

    stackPrint(p);
    stackFree(p);
   return 0;
}
