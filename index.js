// myparser.js
var fs = require("fs");
var jison = require("jison");

var bnf = fs.readFileSync("./exercicio-16-09/grammar.jison", "utf8");
var parser = new jison.Parser(bnf);

// Ler o arquivo de entrada
var input = fs.readFileSync("./exercicio-16-09/input.txt", "utf8");

// Chama o parser para processar a entrada
parser.parse(input);


