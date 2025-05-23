#ifndef MAIN_H
#define MAIN_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *nome;
    char *tipo;
    char *escopo;
    int linha;
} EntradaTabela;

// Declarações EXTERN das variáveis globais (sem alocação de memória)
extern EntradaTabela tabela[];
extern int indice_tabela;
extern char *escopo_atual;
extern int yylineno;

// Protótipos das funções
void add_symbol(const char *nome, const char *tipo);
void print_tabela();

#endif