/*
 * Här kan man stoppa in C-kod som man vill ha först i den
 * C-fil som genereras av Bison.
 */
%{


#include <cstdio>
#include <cassert>
#include "btvt.hpp"
#include "tcv.hpp"
#include "visitor.hpp"

int yylex(void);
int yyerror(char *);
#define YYERROR_VERBOSE

%}

/*
 * Detta deklarerar typen hos de semantiska värdena.
 * I vårt fall kan den typen antingen vara en bokstav eller
 * en struktur med två heltal i.
 */

%{

class Program;
class MainClass;
class ClassDeclSimple;
class ClassDeclExtends;
class VarDecl;
class MethodDecl;
class Formal;
class IntArrayType;
class BooleanType;
class IntegerType;
class IdentifierType;
class Block;
class If;
class While;
class Print;
class Assign;
class ArrayAssign;
class And;
class LessThan;
class Plus;
class Minus;
class Times;
class ArrayLookup;
class ArrayLength;
class Call;
class IntegerLiteral;
class True;
class False;
class IdentifierExp;
class This;
class NewArray;
class NewObject;
class Not;
class Identifier;
//class Type;

union stype {
  Program *program;
  MainClass *mainClass;
  Identifier *identifier;
  Statement *statement;
  Exp *exp;

  Type *type;

  ClassDeclList *classDeclList;
  VarDeclList *varDeclList;
  MethodDeclList *methodDeclList;
  ExpList *expList;

  VarDecl *varDecl;
  ClassDeclSimple *classDeclSimple;
  MethodDecl *methodDecl;
  FormalList *formalList;
  StatementList *statementList;
};

%}


%{
#define YYSTYPE union stype
  char g_identifierBuff[80];
  int g_intLiteral;
%}

/*
 * För att Bison ska veta när den semantiska typen är en bokstav
 * och när den är en struktur, deklareras den semantiska typen hos
 * respektive slutsymboler och icke-slutsymboler nedan. Namnet inom
 * <...> svarar mot respektive namn i %union-deklarationen.
 *
 * Dessa deklarationer gör också att man får typkontroll när man
 * kompilerar den C-fil som genereras av Bison.
 */

%start Goal

%token <token> INTEGER_LITERAL IDENTIFIER AND LESS PLUS MINUS TIMES BOOLEAN INT VOID STRING CLASS PUBLIC STATIC MAIN IF ELSE WHILE RETURN SYSTEM OUT PRINTLN TRUE FALSE THIS NEW LENGTH LPAR RPAR LCURL RCURL LHPAR RHPAR SEMICOLON COMMA DOT NOT ASSIGN
%type <program> Goal
%type <mainClass> MainClass
%type <identifier> Identifier
%type <statement> Statement
%type <type> Type
%type <varDeclList> VarDeclarationList
%type <classDeclList> ClassDeclarationList
%type <methodDeclList> MethodDeclarationList
%type <varDecl> VarDeclaration
%type <classDeclSimple> ClassDeclaration
%type <methodDecl> MethodDeclaration
%type <formalList> TypeIdentifierList ArgumentList
%type <statementList> StatementList
%type <exp> Expression Exp AndExpList AndExp LessThanExp AddativeExp Times PrefixExp NotExp PostfixExp Callee MethodCall
%type <expList> CommaSepExpression

%debug

%%

/* Stoppa in resten av Bison-reglerna här. */
Goal                  : MainClass ClassDeclarationList
                      { $$ = new Program($1, $2);
		      cBtvt p(cSymbolTable::get_instance());
		      p.visit($$);
		      p.get_table().print();

		      printf("Doing typecheck:\n");
		      
		      cTcv tcv(cSymbolTable::get_instance());
		      tcv.visit($$);
		      
		      delete $$; }
                      ;

ClassDeclarationList  : ClassDeclarationList ClassDeclaration { $1->addElement($2); $$ = $1; }
                      | { $$ = new ClassDeclList(); }
                      ;

MainClass             : CLASS Identifier LCURL PUBLIC STATIC VOID MAIN LPAR STRING LHPAR RHPAR Identifier RPAR LCURL Statement RCURL RCURL
                      { $$ = new MainClass($2, $12, $15); }
                      ;                      

ClassDeclaration      :	CLASS Identifier LCURL VarDeclarationList MethodDeclarationList RCURL
                      { $$ = new ClassDeclSimple($2, $4, $5); }
                      ;

/* Gjordes vänsterrekursiv efter tips från migo. */
VarDeclarationList    : VarDeclarationList VarDeclaration { $1->addElement($2); $$ = $1; }
                      | { $$ = new VarDeclList(); }
                      ;
                      
VarDeclaration        : Type Identifier SEMICOLON { $$ = new VarDecl($1, $2); }
                      ;

MethodDeclarationList : MethodDeclarationList MethodDeclaration { $1->addElement($2); }
                      | { $$ = new MethodDeclList(); }
                      ;

MethodDeclaration     : PUBLIC Type Identifier LPAR ArgumentList RPAR LCURL VarDeclarationList StatementList RETURN Expression SEMICOLON RCURL
                      { $$ = new MethodDecl($2, $3, $5, $8, $9, $11); }
                      ;

ArgumentList          : Type Identifier TypeIdentifierList { $$ = $3; $$->addElement(new Formal($1, $2)); }
                      | { $$ = new FormalList(); }
                      ;
                      
TypeIdentifierList    : COMMA Type Identifier TypeIdentifierList { $4->addElement(new Formal($2, $3)); $$ = $4; }
                      | { $$ = new FormalList(); }
                      ;

Type                  : INT LHPAR RHPAR       { $$ = new IntArrayType(); }
                      | BOOLEAN               { $$ = new BooleanType(); }
                      | INT                   { $$ = new IntegerType(); }
                      | Identifier            { $$ = new IdentifierType($1->s); delete $1; }
                      ;

/* Gjordes högerrekursiv efter tips från migo. */
StatementList         : Statement StatementList { $2->addElement($1); $$ = $2; }
                      | { $$ = new StatementList(); }
                      ;

Statement             : LCURL StatementList RCURL                                              { $$ = new Block($2); }
                      | IF LPAR Expression RPAR Statement ELSE Statement                       { $$ = new If($3, $5, $7); }
                      | WHILE LPAR Expression RPAR Statement                                   { $$ = new While($3, $5); }
                      | SYSTEM DOT OUT DOT PRINTLN LPAR Expression RPAR SEMICOLON              { $$ = new Print($7); }
                      | Identifier ASSIGN Expression SEMICOLON                                 { $$ = new Assign($1, $3); }
                      | Identifier LHPAR Expression RHPAR ASSIGN Expression SEMICOLON          { $$ = new ArrayAssign($1, $3, $6); }
                      ;

CommaSepExpression    : CommaSepExpression COMMA Expression { $1->addElement($3); $$ = $1; }
                      | Expression { $$ = new ExpList(); $$->addElement($1); }
                      ;

/***
 * The rules below describe the Expression rule
 */
Expression            : Exp { $$ = $1; }
                      ;
                      
Exp                   : AndExp AndExpList { $$ = new And($1, $2); }
                      | AndExp { $$ = $1; }
                      ;

AndExpList            : AND AndExp AndExpList { $$ = new And($2, $3); }
                      | AND AndExp { $$ = $2; } 
                      ;

AndExp                : LessThanExp { $$ = $1; }
                      ;
                      
LessThanExp           : AddativeExp                               { $$ = $1; }
                      | AddativeExp LESS AddativeExp              { $$ = new LessThan($1, $3); }
                      ;

AddativeExp           : AddativeExp PLUS Times { $$ = new Plus($1, $3); }
                      | AddativeExp MINUS Times { $$ = new Minus($1, $3); }
                      | Times { $$ = $1; }
                      ;
                      
Times                 : Times TIMES PrefixExp { $$ = new Times($1, $3); }
                      | PrefixExp { $$ = $1; }
                      ;
                      
PrefixExp             : NotExp                                    { $$ = $1; }
                      | PostfixExp                                { $$ = $1; }
                      ;
                      
NotExp                : NOT NotExp                                { $$ = new Not($2); }
                      | NOT PostfixExp                            { $$ = new Not($2); }
                      ;

PostfixExp            : INTEGER_LITERAL                           { $$ = new IntegerLiteral(g_intLiteral); }
                      | TRUE                                      { $$ = new True(); }
                      | FALSE                                     { $$ = new False(); }
                      | MethodCall                                { $$ = $1; }
                      ;

Callee                : Identifier                                { $$ = new IdentifierExp($1->s); delete $1; }
                      | NEW INT LHPAR Expression RHPAR            { $$ = new NewArray($4); }
                      | NEW Identifier LPAR RPAR                  { $$ = new NewObject($2); }
                      | Identifier LHPAR Expression RHPAR         { $$ = new ArrayLookup(new IdentifierExp($1->s), $3); delete $1; }
                      | THIS                                      { $$ = new This(); }
                      | LPAR Expression RPAR                      { $$ = $2 }
                      ;


MethodCall            : Callee DOT Identifier LPAR CommaSepExpression RPAR                     { $$ = new Call($1, $3, $5); }
                      | Callee DOT Identifier LPAR RPAR                                        { $$ = new Call($1, $3, new ExpList()); }
                      | Callee DOT LENGTH                                                      { $$ = new ArrayLength($1); }
                      | Callee                                                                 { $$ = $1; }
                      ;

/*--------------------------------------------------------------*/
Identifier            : IDENTIFIER
                      { $$ = new Identifier(g_identifierBuff); /* HACK HACK... */ }
                      ;

/* Om ni får problem med felmeddelandet av typen ("parser.y", line xx) error: type clash (...) on default action kan ni lägga in tomma semantiska åtgärder ({} alltså) efter de regler det blir problem med. */

%%

int main(void)
{
  if (yyparse()) {
    printf("Error in input!\n");
    return 0;
  }
  printf("Input is ok!\n");
  return 0;
}

/*
 * Denna procedur skriver ut felmeddelanden under syntaxanalysen.
 */
int yyerror(char *s)
{
  fprintf(stderr, "%s\n", s);
  return 0;
}
