#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "main.h"
#include <locale.h>

// Protótipos das funções do lexer.l
extern int yylex(void);
extern FILE *yyin;
extern int yylineno;
extern char *yytext;
extern int yyleng;

EntradaTabela tabela[100];
int indice_tabela = 1;
char tipo_atual[32] = "void";

// Função para adicionar símbolos à tabela
void add_symbol(const char *nome, const char *tipo) {
    // Sempre adiciona, mesmo que o nome já exista
    strncpy(tabela[indice_tabela].nome, nome, sizeof(tabela[indice_tabela].nome) - 1);
    tabela[indice_tabela].nome[sizeof(tabela[indice_tabela].nome) - 1] = '\0';
    strncpy(tabela[indice_tabela].tipo, tipo, sizeof(tabela[indice_tabela].tipo) - 1);
    tabela[indice_tabela].tipo[sizeof(tabela[indice_tabela].tipo) - 1] = '\0';
    tabela[indice_tabela].linha = yylineno;
    indice_tabela++;
}

// Função para imprimir a tabela de símbolos
void print_tabela() {
    printf("\nTabela de Símbolos:\n");
    printf("Índice | Nome               | Tipo      \n");
    printf("--------------------------------------------\n");
    for (int i = 1; i < indice_tabela; i++) {
        printf("%6d | %-18s | %-10s\n", 
               i, tabela[i].nome, tabela[i].tipo);
    }
}

// Função principal
int main(int argc, char **argv) {
    setlocale(LC_ALL, "en_US.UTF-8");
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <arquivo_de_entrada>\n", argv[0]);
        return 1;
    }

    // Abre o arquivo de entrada
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Erro ao abrir o arquivo");
        return 1;
    }

    // Executa o analisador léxico
    yylex();

    // Fecha o arquivo e imprime a tabela
    fclose(yyin);
    print_tabela();

    return 0;
}