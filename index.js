// myparser.js
var fs = require("fs");
var jison = require("jison");

var bnf = fs.readFileSync("grammar.jison", "utf8");
var parser = new jison.Parser(bnf);

console.log(parser.parser("teste"))


module.exports = parser;
