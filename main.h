#ifndef MAIN_H
#define MAIN_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <locale.h>

typedef struct {
    char nome[64];
    char tipo[32];
    int linha;
} EntradaTabela;

// Variáveis globais
extern EntradaTabela tabela[];
extern int indice_tabela;
extern char tipo_atual[32];
extern int yylineno;

// Funções
void add_symbol(const char *nome, const char *tipo);
void print_tabela();

#endif