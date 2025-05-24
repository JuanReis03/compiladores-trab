%{
#include "main.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Variáveis globais definidas no main.c
extern EntradaTabela tabela[];
extern int indice_tabela;
extern char tipo_atual[32];
extern int yylineno;
int em_declaracao = 0;

// Função para checar se é palavra-chave
int is_keyword(const char *lexema) {
    const char *keywords[] = {
        "func", "num", "cen", "vec", "check", "repeat", "loop", "return", "void", "let", "color", "from", "to"
    };
    int n = sizeof(keywords)/sizeof(keywords[0]);
    for (int i = 0; i < n; i++) {
        if (strcmp(lexema, keywords[i]) == 0) return 1;
    }
    return 0;
}

// Função para checar se identificador já está na tabela
int symbol_exists(const char *nome) {
    for (int i = 1; i < indice_tabela; i++) {
        if (strcmp(tabela[i].nome, nome) == 0) {
            return 1;
        }
    }
    return 0;
}
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

"num"        {
    printf("<num> ");
    strcpy(tipo_atual, "num");
    em_declaracao = 1;
}

"cen"        {
    printf("<cen> ");
    strcpy(tipo_atual, "cen");
    em_declaracao = 1;
}

"vec"        {
    printf("<vec> ");
    strcpy(tipo_atual, "vec");
    em_declaracao = 1;
}

"func"       {
    printf("<func> ");
    strcpy(tipo_atual, "func");
    em_declaracao = 0;
}

"check"      { printf("<check> "); }
"repeat"     { printf("<repeat> "); }
"loop"       { printf("<loop> "); }
"return"     { printf("<return> "); }
"void"       {
    printf("<void> ");
    strcpy(tipo_atual, "void");
    em_declaracao = 0;
}

"let"        {
    printf("<let> ");
    strcpy(tipo_atual, "string");
    em_declaracao = 1;
}

"color"      {
    printf("<color> ");
    strcpy(tipo_atual, "color");
    em_declaracao = 1;
}

{IDENTIFICADOR} {
    if (!is_keyword(yytext)) {
        if (em_declaracao) {
            add_symbol(yytext, tipo_atual);
            printf("<ID,%d> ", indice_tabela - 1);
            em_declaracao = 0; // Reset após declaração
        } else {
            // Busca o índice mais recente do nome
            int idx = 0;
            for (int i = indice_tabela - 1; i >= 1; i--) {
                if (strcmp(tabela[i].nome, yytext) == 0) {
                    idx = i;
                    break;
                }
            }
            if (idx == 0) {
                // Não existe ainda, adiciona como uso (var)
                add_symbol(yytext, "var");
                printf("<ID,%d> ", indice_tabela - 1);
            } else {
                // Já existe, usa o índice mais recente
                printf("<ID,%d> ", idx);
            }
        }
    }
}

";"         {
    printf("<;> ");
    em_declaracao = 0; // Força reset
    strcpy(tipo_atual, "undef");
}

{DIGITO}+    { printf("<Inteiro, %s> ", yytext); }
{DIGITO}+\.{DIGITO}+ { printf("<Flutuante, %s> ", yytext); }

"-<="       { printf("< -<=, Operacional >"); }
"-<"        { printf("< -<, Operacional > "); }
"->="       { printf("< ->=, Operacional > "); }
"->"        { printf("< ->, Operacional > "); }
":="        { printf("< :=, Operacional > "); }
":!"        { printf("< :!, Operacional > "); }

"&&"        { printf("<&&, Logico> "); }
"||"        { printf("<||, Logico> "); }
"!"         { printf("<!, Logico> "); }

"+"         { printf("<+, Aritmetico> "); }
"-"         { printf("< -, Aritmetico> "); }
"*"         { printf("<*, Aritmetico> "); }
"/"         { printf("</, Aritmetico> "); }
"**"        { printf("<**, Aritmetico> "); }
"="         { printf("< =, Aritmetico> "); }
"+="        { printf("< +=, Aritmetico> "); }
"-="        { printf("< -=, Aritmetico> "); }
"*="        { printf("< *=, Aritmetico> "); }
"/="        { printf("< /=, Aritmetico> "); }

"{"         { printf("<{> "); }
"}"         { printf("<}> "); }
"("         { printf("<(> "); }
")"         { printf("<)> "); }
"["         { printf("<[> "); }
"]"         { printf("<]> "); }
","         { printf("<,> "); }
";"         { printf("<;> "); }

\"[^\"]*\"  {
    printf("<String, %s> ", yytext);
    if (!symbol_exists(yytext)) {
        add_symbol(yytext, "string");
    }
}

#[0-9A-Fa-f]{6} {
    printf("<Color, %s> ", yytext);
    if (!symbol_exists(yytext)) {
        add_symbol(yytext, "color");
    }
}

\n          ;  // Ignora quebras de linha

.           {
    printf("\nErro léxico: caractere inválido '%s' (linha %d)\n",
           yytext, yylineno);
}

%%