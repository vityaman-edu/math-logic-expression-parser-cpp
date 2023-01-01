#ifndef CPP_SOLUTION_EXPRESSION_H
#define CPP_SOLUTION_EXPRESSION_H

#include <string>

class Expression {
public:
    virtual std::string asString() = 0;
    virtual ~Expression() {};
};

class BinaryOperation : public Expression {
public:
    BinaryOperation(
        std::string const & symbol, 
        Expression* left,
        Expression* right
    ) : _symbol(symbol), 
        _left(left),
        _right(right) {}

    std::string asString() override {
        return "(" 
            + _symbol + "," 
            + _left->asString() + "," 
            + _right->asString() 
            + ")";
    }

private:
    std::string _symbol;
    Expression* _left;
    Expression* _right;
};

class Implication : public BinaryOperation {
public:
    Implication(
        Expression* left,
        Expression* right
    ) : BinaryOperation("->", left, right) {}
};

class Disjunction : public BinaryOperation {
public:
    Disjunction(
        Expression* left,
        Expression* right
    ) : BinaryOperation("|", left, right) {}
};

class Conjunction : public BinaryOperation {
public:
    Conjunction(
        Expression* left,
        Expression* right
    ) : BinaryOperation("&", left, right) {}
};

class UnaryOperation : public Expression {
public:
    UnaryOperation(
        std::string const & symbol,
        Expression* child
    ) : _symbol(symbol),
        _child(child) {}

    std::string asString() override {
        return "(" 
            + _symbol 
            + _child->asString() 
            + ")";
    }

private:
    std::string _symbol;
    Expression* _child;
};

class Negation : public UnaryOperation {
public:
    Negation(
        Expression* child
    ) : UnaryOperation("!", child) {}
};

class Variable : public Expression {
public:
    Variable(std::string& name)
        : _name(name) {}

    std::string asString() {
        return _name;
    }

private:
    std::string _name;
};

#endif //CPP_SOLUTION_EXPRESSION_H
