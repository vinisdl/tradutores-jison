// myparser.js
var fs = require("fs");
var jison = require("jison");

var bnf = fs.readFileSync("new_grammar.jison", "utf8");
var parser = new jison.Parser(bnf);

// Ler o arquivo de entrada
var input = fs.readFileSync("input.txt", "utf8");

// Chama o parser para processar a entrada
parser.parse(input);


