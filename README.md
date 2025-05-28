# Trabalho 1 - Analisador Léxico 

Este projeto implementa um analisador léxico para a linguagem criada pelo grupo, desenvolvida como parte da disciplina MATA61 - Compiladores. O analisador é responsável por:
- Identificar tokens (palavras-chave, identificadores, operadores, etc.)
- Gerar uma tabela de símbolos durante a análise
- Reportar erros léxicos com localização precisa

## ⚙️ Como compilar e executar

### Pré-requisitos
- Flex 2.6.4+
- GCC 11+

# Passo a passo:

### 1. Gerar o analisador léxico a partir da especificação
**flex lexer.l**

### 2. Compilar o projeto (duas opções):
- ###    Opção 1: Com linking da biblioteca Flex
**gcc main.c lex.yy.c -o compilador -lfl**

- ###    Opção 2: Sem biblioteca adicional
**gcc main.c lex.yy.c -o compilador**

### 3. Executar com um arquivo de entrada
**./compilador exemplo.txt**

## 📊 Saída do programa
O programa produzirá duas partes principais:

1. Sequência de tokens no formato: <TIPO, VALOR>.
```
Exemplo: <func> <ID,1> <(> <num> <ID,2> ... 

```

2. Tabela de símbolos contendo:

- Índice único para cada identificador
- Nome do símbolo
- Tipo inferido (num, cen, vec, etc.)

Exemplo parcial de saída:

```
<func> <ID,1> <(> <num> <ID,2> ...
Tabela de Símbolos:

 Índice | Nome      | Tipo
----------------------------
     1  | soma      | func
     2  | a         | num 
     3  | x         | var 

``` 

## 🧪 Testando com outros arquivos
Para analisar outros códigos:

````
bash

./compilador seu_arquivo.txt
````
## 📂 Estrutura de arquivos

| Arquivo       | Descrição                                  |
|---------------|--------------------------------------------|
| `lexer.l`     | Especificação léxica (Flex)                |
| `main.c`      | Implementação da tabela de símbolos        |
| `main.h`      | Definições de estruturas e funções         |
| `exemplo.txt` | Programa de exemplo em NeoLang             |
| `lex.yy.c`    | Código gerado pelo Flex (não editar)       |


## ✨ Recursos implementados
- Reconhecimento de operadores customizados (`-<`, `->=`, etc.)
- Suporte a vetores, cores hexadecimais e strings
- Tratamento de erros com reporte de linha
- Tabela de símbolos dinâmica

---

## 👥 Integrantes do grupo
- Juan Reis dos Santos
- Caio Adriel Barbosa dos Santos
