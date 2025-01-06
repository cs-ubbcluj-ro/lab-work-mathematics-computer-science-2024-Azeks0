%{
#include "mini_language.tab.h"
%}

%%
[ \t\n\r]+                 /* Ignore whitespace */
[0-9]+                     { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z][a-zA-Z0-9]*       { yylval.str = strdup(yytext); return IDENTIFIER; }
"+"                        { return PLUS; }
"-"                        { return MINUS; }
"*"                        { return TIMES; }
"/"                        { return DIVIDE; }
"="                        { return ASSIGN; }
";"                        { return SEMICOLON; }
"("                        { return LPAREN; }
")"                        { return RPAREN; }
.                          { return 0; }  /* Any other character is invalid */
%%

int yywrap(void) {
    return 1;
}
                                                                                                                                                                             

