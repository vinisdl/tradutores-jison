
<function_call>  ::= <IDENTIFIER> <arguments> ";"

<primary_<expression>> ::= <IDENTIFIER> | <literal> | "(" <<expression>> ")"

<arguments> ::= "(" ")" | "(" <argument_list> ")"

<argument_list> ::= <assignment_<expression>> | <argument_list> "," <assignment_<expression>>

<left_hand_side_<expression>> ::= <primary_<expression>> | <function_call> 

<unary_<expression>> ::= <left_hand_side_<expression>> | "+" <unary_<expression>> | "-" <unary_<expression>>    
    
<multiplicative_<expression>> ::= <unary_<expression>> | <multiplicative_<expression>> '*' <multiplicative_<expression>> | <multiplicative_<expression>> '/' <multiplicative_<expression>>

<additive_<expression>> ::= <multiplicative_<expression>> | <additive_<expression>> "+" <multiplicative_<expression>> | <additive_<expression>> "-" <multiplicative_<expression>>

<assignment_<expression>> ::= <additive_<expression>>

<expression> ::= <additive_<expression>> | <expression> "," <additive_<expression>>

<literal> ::= <numeric_literal> | <string_literal>

<numeric_literal> ::= <NUMBER_LITERAL> | <IMAGINARY_LITERAL>

<string_literal> : <string_literal>
