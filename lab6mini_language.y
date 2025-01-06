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
        free($1); // Free memory for the identifier string
    }
    ;

expression:
    expression PLUS term
    {
        $$ = $1 + $3;  // $$ is the result of the expression
    }
    | expression MINUS term
    {
        $$ = $1 - $3;
    }
    | term
    ;

term:
    term TIMES factor
    {
        $$ = $1 * $3;
    }
    | term DIVIDE factor
    {
        if ($3 == 0) {
            yyerror("Division by zero!");
            YYABORT;
        }
        $$ = $1 / $3;
    }
    | factor
    ;

factor:
    NUMBER
    {
        $$ = $1;  // $1 is the value of the number
    }
    | IDENTIFIER
    {
        printf("Variable: %s\n", $1);  
        $$ = 0; // Return 0 for variables for now
        free($1); // Free memory for the identifier string
    }
    | LPAREN expression RPAREN
    {
        $$ = $2;  // Return the value of the expression inside parentheses
    }
    ;

%%

int main() {
    printf("Enter a program:\n");
    yyparse();  
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
