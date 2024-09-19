/* Autores: Marco Vinícius, Matheus Milanezi.
/* Descrição: Lexer e Parser com tabela de símbolos para rastrear identificadores e palavras reservadas */

/* JavaScript section to track symbols */
%{
    let symbolTable = {};  // Tabela de símbolos para armazenar os identificadores
    let idCounter = 1;     // Contador que cria índices únicos para os identificadores

    function trackIdentifier(ident) {
        if (symbolTable[ident]) {
            console.log(`Identificador repetido: ${ident} (Já foi registrado como IDENTIFICADOR${symbolTable[ident]})`);
        } else {
            symbolTable[ident] = idCounter++;
            console.log(`Novo identificador: ${ident} registrado como IDENTIFICADOR${symbolTable[ident]}`);
        }
    }
%}

/* lexical grammar */
%lex
%%
\s+                        /* skip */
[a-zA-Z][a-zA-Z0-9]{0,31}   {
    if (yytext === 'int' || yytext === 'double' || yytext === 'float' ||
        yytext === 'real' || yytext === 'break' || yytext === 'case' ||
        yytext === 'char' || yytext === 'const' || yytext === 'continue' ||
        yytext === 'while' || yytext === 'for' || yytext === 'if' || yytext === 'else') {
        return 'PALAVRA_RESERVADA';
    } else {
        return 'IDENTIFICADOR';
    }
}

[0-9]+\.[0-9]+             return 'DOUBLE'; // Números de ponto flutuante (double)

[0-9]{1,8}                 return 'INTEIRO'; // Números inteiros até 8 dígitos

\/\/[^\n]*                  return 'COMENTARIO';  // Comentário no estilo JS (//)

<<EOF>>                     return 'EOF';  // Fim do arquivo

.                           return 'ERRO_LEXICO';  // Qualquer outro símbolo é erro
/lex

%start programa

%% /* language grammar */

programa
    : lista_tokens EOF
        { 
            console.log("Tabela de Símbolos:", symbolTable);
            console.log("Análise completa sem erros."); 
            return $1; 
        }
    ;

lista_tokens
    : lista_tokens token
    | token
    ;

token
    : 'IDENTIFICADOR'  { trackIdentifier(yytext); }
    | 'INTEIRO'        { console.log(`Número inteiro: ${yytext}`); }
    | 'DOUBLE'         { console.log(`Número double: ${yytext}`); }
    | 'COMENTARIO'     { console.log(`Comentário: ${yytext}`); }
    | 'PALAVRA_RESERVADA' { console.log(`Palavra reservada: ${yytext}`); }
    | 'ERRO_LEXICO'    { console.error(`Erro léxico: ${yytext}`); }
    ;
