// myparser.js
var fs = require("fs");
var jison = require("jison");

let pasta = "./exercicio-grau-a/"


var bnf = fs.readFileSync(`${pasta}grammar.jison`, "utf8");
var parser = new jison.Parser(bnf);

// Ler o arquivo de entrada
var input = fs.readFileSync(`${pasta}/input.txt`, "utf8");

// Chama o parser para processar a entrada
parser.parse(input);


