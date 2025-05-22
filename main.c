#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Estrutura da Tabela de Símbolos
typedef struct {
    char *nome;
    char *tipo;
    char *escopo;
    int linha;
} EntradaTabela;

// Variáveis globais
EntradaTabela tabela[100];
int indice_tabela = 0;
char *escopo_atual = "global";

// Protótipos das funções do lexer.l
extern int yylex(void);
extern FILE *yyin;

// Função para adicionar símbolos à tabela
void add_symbol(const char *nome, const char *tipo) {
    tabela[indice_tabela].nome = strdup(nome);
    tabela[indice_tabela].tipo = strdup(tipo);
    tabela[indice_tabela].escopo = strdup(escopo_atual);
    tabela[indice_tabela].linha = yylineno;
    indice_tabela++;

    if (indice_tabela >= 100) {
        fprintf(stderr, "Erro: Tabela de símbolos cheia!\n");
        exit(1);
    }
}

// Função para imprimir a tabela de símbolos
void print_tabela() {
    printf("\nTabela de Símbolos:\n");
    printf("Índice | Nome      | Tipo        | Escopo\n");
    printf("--------------------------------------------\n");
    for (int i = 0; i < indice_tabela; i++) {
        printf("%6d | %-9s | %-10s | %s\n", 
               i, tabela[i].nome, tabela[i].tipo, tabela[i].escopo);
    }
}

// Função principal
int main(int argc, char **argv) {
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