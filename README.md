# compiladores-trab

# Como compilar, executar e testar (faça esses comandos no terminal):

## 1. gerar o lexer

flex lexer.l 

## 2. compila o projeto

gcc main.c lex.yy.c -o compilador -lfl 

ou então, sem o "-lfl"

gcc main.c lex.yy.c -o compilado

## 3. executa arquivo exemplo

./compilador exemplo.txt
