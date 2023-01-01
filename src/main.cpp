#include "Expression.h"
#include "parse/gen/Expression.tab.hpp"
#include "parse/gen/Expression.lexer.hpp"
#include <iostream>

extern Expression* result;

void yyerror(const char *error) {
    std::cerr << error;
}

int yywrap() {
    return 1;
}

int main() {
    std::string input;
    std::cin >> input;
    yy_scan_string(input.c_str());
    yyparse();
    std::cout 
        << result->asString() 
        << std::endl;
    return 0;
}