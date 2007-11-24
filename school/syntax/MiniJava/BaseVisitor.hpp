#ifndef _BASE_VISITOR_HPP_
#define _BASE_VISITOR_HPP_

/* ===========================[Forward declarations]============================== */
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

/* ===========================[Abstract classes]============================== */
class Visitor {
public:
  virtual void visit(Program &n)=0;
  virtual void visit(MainClass &n)=0;
  virtual void visit(ClassDeclSimple &n)=0;
  virtual void visit(ClassDeclExtends &n)=0;
  virtual void visit(VarDecl &n)=0;
  virtual void visit(MethodDecl &n)=0;
  virtual void visit(Formal &n)=0;
  virtual void visit(IntArrayType &n)=0;
  virtual void visit(BooleanType &n)=0;
  virtual void visit(IntegerType &n)=0;
  virtual void visit(IdentifierType &n)=0;
  virtual void visit(Block &n)=0;
  virtual void visit(If &n)=0;
  virtual void visit(While &n)=0;
  virtual void visit(Print &n)=0;
  virtual void visit(Assign &n)=0;
  virtual void visit(ArrayAssign &n)=0;
  virtual void visit(And &n)=0;
  virtual void visit(LessThan &n)=0;
  virtual void visit(Plus &n)=0;
  virtual void visit(Minus &n)=0;
  virtual void visit(Times &n)=0;
  virtual void visit(ArrayLookup &n)=0;
  virtual void visit(ArrayLength &n)=0;
  virtual void visit(Call &n)=0;
  virtual void visit(IntegerLiteral &n)=0;
  virtual void visit(True &n)=0;
  virtual void visit(False &n)=0;
  virtual void visit(IdentifierExp &n)=0;
  virtual void visit(This &n)=0;
  virtual void visit(NewArray &n)=0;
  virtual void visit(NewObject &n)=0;
  virtual void visit(Not &n)=0;
  virtual void visit(Identifier &n)=0;
};

class TypeVisitor {
public:
  virtual Type* visit(Program &n)=0;
  virtual Type* visit(MainClass &n)=0;
  virtual Type* visit(ClassDeclSimple &n)=0;
  virtual Type* visit(ClassDeclExtends &n)=0;
  virtual Type* visit(VarDecl &n)=0;
  virtual Type* visit(MethodDecl &n)=0;
  virtual Type* visit(Formal &n)=0;
  virtual Type* visit(IntArrayType &n)=0;
  virtual Type* visit(BooleanType &n)=0;
  virtual Type* visit(IntegerType &n)=0;
  virtual Type* visit(IdentifierType &n)=0;
  virtual Type* visit(Block &n)=0;
  virtual Type* visit(If &n)=0;
  virtual Type* visit(While &n)=0;
  virtual Type* visit(Print &n)=0;
  virtual Type* visit(Assign &n)=0;
  virtual Type* visit(ArrayAssign &n)=0;
  virtual Type* visit(And &n)=0;
  virtual Type* visit(LessThan &n)=0;
  virtual Type* visit(Plus &n)=0;
  virtual Type* visit(Minus &n)=0;
  virtual Type* visit(Times &n)=0;
  virtual Type* visit(ArrayLookup &n)=0;
  virtual Type* visit(ArrayLength &n)=0;
  virtual Type* visit(Call &n)=0;
  virtual Type* visit(IntegerLiteral &n)=0;
  virtual Type* visit(True &n)=0;
  virtual Type* visit(False &n)=0;
  virtual Type* visit(IdentifierExp &n)=0;
  virtual Type* visit(This &n)=0;
  virtual Type* visit(NewArray &n)=0;
  virtual Type* visit(NewObject &n)=0;
  virtual Type* visit(Not &n)=0;
  virtual Type* visit(Identifier &n)=0;
};

#endif

