CXXFLAGS=-std=c++14 -Wall -O2 -I src
CXX=g++
GR_DIR=src/parse
BISON_GEN_DIR=$(GR_DIR)/gen

all: build
	$(CXX) $(CXXFLAGS) \
		-o build/app \
		src/main.cpp \
		src/parse/gen/Expression.lexer.cpp \
		src/parse/gen/Expression.tab.cpp



# Generate parser
$(BISON_GEN_DIR)/%.lexer.cpp $(BISON_GEN_DIR)/%.lexer.hpp: $(GR_DIR)/%.lex $(BISON_GEN_DIR)
	flex $(GR_DIR)/$*.lex
	mv lex.cpp $(BISON_GEN_DIR)/$*.lexer.cpp
	mv lex.hpp $(BISON_GEN_DIR)/$*.lexer.hpp

$(BISON_GEN_DIR)/%.tab.cpp $(BISON_GEN_DIR)/%.tab.hpp: $(GR_DIR)/%.y $(BISON_GEN_DIR)
	bison -d -v $< -o $(BISON_GEN_DIR)/$*.tab.cpp

$(BISON_GEN_DIR):
	mkdir -p src/parse/gen

build/app: src/main.cpp $(BISON_GEN_DIR)/Expression.lexer.cpp $(BISON_GEN_DIR)/Expression.tab.cpp
	$(CXX) $(CXXFLAGS) -o build/app $^

bison-codegen: $(BISON_GEN_DIR)/Expression.lexer.cpp $(BISON_GEN_DIR)/Expression.tab.cpp

compile: build build/app

run: 
	./build/app

build:
	mkdir -p build

dist:
	mkdir -p dist

clean:
	rm -rf build
	rm -rf dist
	rm -rf $(BISON_GEN_DIR)

release: clean bison-codegen dist
	zip dist/expression_parser.zip -r Makefile src
