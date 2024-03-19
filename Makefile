 # -------------------------------------------------------------------
 #            Arquivo: Makefile
 # -------------------------------------------------------------------
 #              Autor: Bruno Müller Junior
 #               Data: 08/2007
 #      Atualizado em: [09/08/2020, 19h:01m]
 #
 # -------------------------------------------------------------------

$DEPURA=1

compilador: lex.yy.c compilador.tab.c compilador.o compilador.h stack.o stack.h
	gcc lex.yy.c compilador.tab.c compilador.o stack.o -o compilador -ll -ly -lc

lex.yy.c: compilador.l compilador.h stack.h
	flex compilador.l

compilador.tab.c: compilador.y compilador.h stack.h
	bison compilador.y -d -v

compilador.o : compilador.h compiladorF.c stack.h
	gcc -c compiladorF.c -o compilador.o

stack: stack.o
	gcc -o stack stack.o -g -Wall

stack.o: stack.c stack.h
	gcc -c stack.c -g -Wall

clean :
	rm -f compilador.tab.* lex.yy.c compilador.o compilador stack.o stack
