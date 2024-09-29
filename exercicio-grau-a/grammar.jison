%lex

%x paren

%%

\s+                   /* skip whitespace */
<INITIAL>"("         { this.begin("paren"); parenCount = 1; return "parenStart"; };
<paren>"("            { console.log("parenStart", parenCount); parenCount++; return "parenInterior"; };
<paren>")"            { console.log("parenEnd", parenCount); parenCount--; if (parenCount === 0) { this.popState(); return "parenEnd"; } else { return "parenInterior"; } };
<paren>[^\)\(]+       { console.log(this); return "parenInterior"; };
[";"]                 return 'DOTCOMMA'
"printf"           return 'PRINTF';  // Comando printf
<<EOF>>               return 'EOF';
.                     return 'PARAM';

/lex

%start expressions

%% /* language grammar */

expressions
    : PRINTF parenStart parenInteriorSeq parenEnd DOTCOMMA EOF { return $1 + $2 + $3 + $4 + $5; }
    ;

parenInteriorSeq
    : parenInterior 
    | parenInteriorSeq parenInterior -> $1.concat($2)
    ;

PARAMSeq
    : -> ""      // Empty sequence.
    | PARAMs  // One or more PARAM tokens.
    ;

PARAMs
    : PARAM
    | PARAMSeq PARAM -> $1.concat($2)
    ;

DOTCOMMAs
    : DOTCOMMA
    | DOTCOMMAs DOTCOMMA -> $1.concat($2)
    ;

%%

parenCount = 0;