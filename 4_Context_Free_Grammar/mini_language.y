%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

%}

%union {
    int num;      // For numbers (integers)
    char* str;    // For identifiers (strings)
}

%token <num> NUMBER
%token <str> IDENTIFIER
%token ASSIGN SEMICOLON
%token PLUS MINUS TIMES DIVIDE LPAREN RPAREN

%left PLUS MINUS
%left TIMES DIVIDE
%nonassoc UMINUS

%type <num> program statement_list statement assignment expression term factor

%%

program:
    statement_list
    ;

statement_list:
    statement
    | statement_list statement
    ;

statement:
    assignment
    | expression
    ;

assignment:
    IDENTIFIER ASSIGN expression SEMICOLON
    {
        printf("Assignment: %s = %d\n", $1, $3);  // $1 is IDENTIFIER, $3 is the result of the expression
        free($1); // Remember to free the allocated memory for the string
    }
    ;

expression:
    expression PLUS term
    {
        $$ = $1 + $3;  // $$ is the result of the expression
    }

