%{
#include "mini_language.tab.h"  
%}

%%

[0-9]+          { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return IDENTIFIER; }
"="             { return ASSIGN; }
";"             { return SEMICOLON; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return TIMES; }
"/"             { return DIVIDE; }
"("             { return LPAREN; }
")"             { return RPAREN; }

[ \t\n]+        ;  // Ignore whitespace (spaces, tabs, newlines)

%%

int yywrap(void) {
    return 1;  // End of input
}
