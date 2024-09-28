

%lex

%x string

%%
\\s+              /* skip */;   // Ignorar espaços em branco
[\(]              return "(";      // Parêntese esquerdo
[\)]              return ")";      // Parêntese direito
["]               this.pushState("string");
<string>[^"]*   return "STRING";
<string>["]       this.popState();
"printf"           return 'PRINTF';  // Comando printf

[a-zA-Z_][a-zA-Z0-9_]* return 'VAR'; // Variável
[0-9]+           return 'NUMBER';  // Número
"+"              return 'OPERATOR'; // Operador +
"-"                return 'OPERATOR'; // Operador -
"*"              return 'OPERATOR'; // Operador *
"/"                return 'OPERATOR'; // Operador /
;                return ";";      // Ponto e vírgula
return             return "return"; // Palavra-chave return
<<EOF>>                     return 'EOF';  // Fim do arquivo
.                           return 'ERRO_LEXICO';  // Qualquer outro símbolo é erro

/lex

%start program
%token PRINTF STRING NUMBER OPERATOR

%% 

program
    : statement_list
    ;

statement_list
    : statement_list statement
    | statement
    ;

statement
    : PRINTF '(' expression ')' ';'    { console.log($3); }
    ;

expression
    : STRING                            { $$ = $1; }
    | arithmetic_expression             { $$ = $1; }
    | function_return                   { $$ = $1; }
    ;

arithmetic_expression
    : term (OPERATOR term)*            { 
        $$ = $1; 
        for (let i = 0; i < $2.length; i++) {
            $$ = eval($$ + $2[i][0] + $2[i][1]); // Calcula a operação
        }
    }
    ;

term
    : NUMBER                            { $$ = $1; }
    ;
