%lex
DDS [0-9]
NZD [1-9]
DSI [-+]?{DDS}
DEI [eE]
DEP {DEI}{DSI}
DIL [0]|({NZD}{DDS}*)
decimalnumber (({DIL}\.{DDS}*{DEP}?)|(\.{DDS}{DEP}?)|({DIL}{DEP}?))
imaginarydecimalnumber {decimalnumber}[i]
escapechar [\'\"\\bfnrtv]
escape \\{escapechar}
acceptedcharssingle [^\'\\]+
acceptedcharsdouble [^\"\\]+
stringsingle {escape}|{acceptedcharssingle}
stringdouble {escape}|{acceptedcharsdouble}
stringliteral (\'{stringsingle}*\')|(\"{stringdouble}*\")

%options flex
%%
\s+                   /* skip whitespace */

"/*"(.|\n|\r)*?"*/" /* ignore multiline comment. No single line comment, sorry */

{stringliteral}                  return 'STRING_LITERAL'
[a-zA-Z_$@][a-zA-Z0-9_]*	    return 'IDENTIFIER'
{decimalnumber}                 return 'NUMBER_LITERAL'

"*"      return '*'
"/"      return '/'
"-"      return '-'
"+"      return '+'
"("      return '('
")"      return ')'
";"      return ';'
","      return ','
<<EOF>>               return 'EOF'
.        return 'INVALID'
/lex

%token STRINGLITERAL NUMBERLITERAL IMAGINARYLITERAL


%token 
%start function_call
%%

primary_expression
    : IDENTIFIER
    | literal         /* numeros, strings */
    | "(" expression ")"
    ;

function_call  
    : IDENTIFIER arguments ";" EOF
    ;

arguments
    : "(" ")"
    | "(" argument_list ")"
    ;

argument_list
    : argument_list "," IDENTIFIER arguments
    | assignment_expression
    | argument_list "," assignment_expression
    ;

left_hand_side_expression
    : primary_expression
    | function_call
    | array_call
    ; 

unary_expression
    : left_hand_side_expression 
    | "+" unary_expression    
    | "-" unary_expression    
    ;

multiplicative_expression
    : unary_expression    
    | multiplicative_expression '*' multiplicative_expression    
    | multiplicative_expression '/' multiplicative_expression    
    ;

additive_expression
    : multiplicative_expression    
    | additive_expression "+" multiplicative_expression
    | additive_expression "-" multiplicative_expression
    ;

assignment_expression
    : additive_expression
    ;

expression
    : additive_expression
    | expression "," additive_expression
    ;

literal
    : numeric_literal 
    | string_literal
    ;

numeric_literal
    : NUMBER_LITERAL
    | IMAGINARY_LITERAL
    ;

string_literal
    : STRING_LITERAL
    ;

%%