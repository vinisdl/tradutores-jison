%{
  function yyerror(err) {
    console.error("Error: " + err);
  }
%}

%lex

%%
// Definição de tokens
"print"|"printf"          { return 'FUNCTION'; }
"\""                      { return 'STRING_START'; }
"\\\"?"[^\"\n]*"\""      { return 'STRING'; }
"%"                       { return 'PERCENT'; }
"\\d+"                   { return 'NUMBER'; }
"nro"                     { return 'IDENTIFIER'; }
"("                       { return 'LPAREN'; }

")"                       { return 'RPAREN'; }

","                       { return 'COMMA'; }
[ \t\n\r]+                { /* ignora espaços em branco */ }
.                         { return 'ERROR'; }

%%

/lex

// Precedência dos operadores
%left '+' '-'
%left '*' '/'

// Regras do parser
%start start

%%

start
  : statements
  ;

statements
  : statements statement
  | statement
  ;

statement
  : FUNCTION LPAREN args RPAREN ';'
  ;

token
    : LPAREN {}
    | RPAREN {}
    ;

args
  : STRING
  | STRING COMMA expression
  | expression
  | expression COMMA args
  ;

expression
  : term
  | expression '+' term
  | expression '-' term
  ;

term
  : factor
  | term '*' factor
  | term '/' factor
  ;

factor
  : IDENTIFIER
  | NUMBER
  | FUNCTION LPAREN args RPAREN
  | LPAREN expression RPAREN
  ;

%%

// Tratamento de erro global

