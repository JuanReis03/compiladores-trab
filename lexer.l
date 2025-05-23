%{
#include "main.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Variáveis globais definidas no main.c
extern EntradaTabela tabela[];
extern int indice_tabela;
extern char *escopo_atual;
extern int yylineno;

%}

%option noyywrap yylineno

DIGITO       [0-9]
LETRA        [a-zA-Z_]
IDENTIFICADOR {LETRA}({LETRA}|{DIGITO})*
ESPACO       [ \t]
COMENTARIO   #.*

%%

{ESPACO}     ;  // Ignora espaços
{COMENTARIO} ;  // Ignora comentários

"num"        { printf("<KW_NUM> "); add_symbol(yytext, "num"); }
"cen"        { printf("<KW_CEN> "); add_symbol(yytext, "cen"); }
"vec"        { printf("<KW_VEC> "); add_symbol(yytext, "vec"); }
"func"       { printf("<KW_FUNC> "); add_symbol(yytext, "func"); }
"check"      { printf("<KW_CHECK> "); }
"repeat"     { printf("<KW_REPEAT> "); }
"loop"       { printf("<KW_LOOP> "); }
"return"     { printf("<KW_RETURN> "); }
"void"       { printf("<KW_VOID> "); }
"let"        { printf("<KW_LET> "); }
"color"      { printf("<KW_COLOR> "); }

{IDENTIFICADOR} {
    printf("<ID,%d> ", indice_tabela);
    add_symbol(yytext, "id");
}

{DIGITO}+    { printf("<LIT_INT,%s> ", yytext); }
{DIGITO}+\.{DIGITO}+ { printf("<LIT_FLOAT,%s> ", yytext); }

"-<="       { printf("<OP_LE> "); }
"-<"        { printf("<OP_LT> "); }
"->="       { printf("<OP_GE> "); }
"->"        { printf("<OP_GT> "); }
":="        { printf("<OP_EQ> "); }
":!"        { printf("<OP_NE> "); }

"&&"        { printf("<OP_AND> "); }
"||"        { printf("<OP_OR> "); }
"!"         { printf("<OP_NOT> "); }

"+"         { printf("<OP_ADD> "); }
"-"         { printf("<OP_SUB> "); }
"*"         { printf("<OP_MUL> "); }
"/"         { printf("<OP_DIV> "); }
"**"        { printf("<OP_POW> "); }
"="         { printf("<OP_ASSIGN> "); }
"+="        { printf("<OP_ADD_ASSIGN> "); }
"-="        { printf("<OP_SUB_ASSIGN> "); }
"*="        { printf("<OP_MUL_ASSIGN> "); }
"/="        { printf("<OP_DIV_ASSIGN> "); }

"{"         { printf("<LBRACE> "); }
"}"         { printf("<RBRACE> "); }
"("         { printf("<LPAREN> "); }
")"         { printf("<RPAREN> "); }
"["         { printf("<LBRACKET> "); }
"]"         { printf("<RBRACKET> "); }
","         { printf("<COMMA> "); }
";"         { printf("<SEMICOLON> "); }

\"[^\"]*\"  { printf("<LIT_STR,%s> ", yytext); }  // Strings
#[0-9A-Fa-f]{6} { printf("<LIT_COLOR,%s> ", yytext); }  // Cores

\n          ;  // Ignora quebras de linha

.           { printf("\nErro léxico: caractere inválido '%s' (linha %d)\n", yytext, yylineno); }

%%