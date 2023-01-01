%{
#include <iostream>
#include <string>
#include "Expression.h"

int yylex(void);
void yyerror(const char *);

Expression* result = nullptr;
%}

%union {    
Expression* e;
std::string* name;
}

%token <name> NAME
%token IMP OR AND NEG
%token LEFT RIGHT
%token END

%right IMP
%left OR
%left AND
%left NEG

%type <e> Input Expression

%start Input

%%
Input
    : Expression { result = $1; }
    ;

Expression
    : Expression IMP Expression { $$ = new Implication($1, $3); }
    | Expression OR Expression  { $$ = new Disjunction($1, $3); }
    | Expression AND Expression { $$ = new Conjunction($1, $3); }
    | NEG Expression            { $$ = new Negation($2);        }
    | LEFT Expression RIGHT     { $$ = $2;                      }
    | NAME                      { $$ = new Variable(*$1);       }
    ;

%%
