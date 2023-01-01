%{
#include <string>
#include "Expression.h"
#include "parse/gen/Expression.tab.hpp"
%}

%option outfile="lex.cpp" header-file="lex.hpp"

white [ \t]+    
digit [0-9]
letter [A-Z`']
symbol {letter}({letter}|{digit})*

%%
{symbol} {
    yylval.name = new std::string(yytext);
    return NAME;
}
"&"  return AND;
"|"  return OR;
"->" return IMP;
"!"  return NEG;
"("  return LEFT;
")"  return RIGHT;
"\n" return END;
%%
