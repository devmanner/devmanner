#ifndef _TYPES_HPP_
#define _TYPES_HPP_

#include <string>
#include <deque>
#include <cstdio>

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
class Type;

/* ===========================[Abstract classes]============================== */
class Visitor {
public:
  virtual void visit(Program *n)=0;
  virtual void visit(MainClass *n)=0;
  virtual void visit(ClassDeclSimple *n)=0;
  virtual void visit(ClassDeclExtends *n)=0;
  virtual void visit(VarDecl *n)=0;
  virtual void visit(MethodDecl *n)=0;
  virtual void visit(Formal *n)=0;
  virtual void visit(IntArrayType *n)=0;
  virtual void visit(BooleanType *n)=0;
  virtual void visit(IntegerType *n)=0;
  virtual void visit(IdentifierType *n)=0;
  virtual void visit(Block *n)=0;
  virtual void visit(If *n)=0;
  virtual void visit(While *n)=0;
  virtual void visit(Print *n)=0;
  virtual void visit(Assign *n)=0;
  virtual void visit(ArrayAssign *n)=0;
  virtual void visit(And *n)=0;
  virtual void visit(LessThan *n)=0;
  virtual void visit(Plus *n)=0;
  virtual void visit(Minus *n)=0;
  virtual void visit(Times *n)=0;
  virtual void visit(ArrayLookup *n)=0;
  virtual void visit(ArrayLength *n)=0;
  virtual void visit(Call *n)=0;
  virtual void visit(IntegerLiteral *n)=0;
  virtual void visit(True *n)=0;
  virtual void visit(False *n)=0;
  virtual void visit(IdentifierExp *n)=0;
  virtual void visit(This *n)=0;
  virtual void visit(NewArray *n)=0;
  virtual void visit(NewObject *n)=0;
  virtual void visit(Not *n)=0;
  virtual void visit(Identifier *n)=0;
};

class TypeVisitor {
public:
  virtual Type* visit(Program *n)=0;
  virtual Type* visit(MainClass *n)=0;
  virtual Type* visit(ClassDeclSimple *n)=0;
  virtual Type* visit(ClassDeclExtends *n)=0;
  virtual Type* visit(VarDecl *n)=0;
  virtual Type* visit(MethodDecl *n)=0;
  virtual Type* visit(Formal *n)=0;
  virtual Type* visit(IntArrayType *n)=0;
  virtual Type* visit(BooleanType *n)=0;
  virtual Type* visit(IntegerType *n)=0;
  virtual Type* visit(IdentifierType *n)=0;
  virtual Type* visit(Block *n)=0;
  virtual Type* visit(If *n)=0;
  virtual Type* visit(While *n)=0;
  virtual Type* visit(Print *n)=0;
  virtual Type* visit(Assign *n)=0;
  virtual Type* visit(ArrayAssign *n)=0;
  virtual Type* visit(And *n)=0;
  virtual Type* visit(LessThan *n)=0;
  virtual Type* visit(Plus *n)=0;
  virtual Type* visit(Minus *n)=0;
  virtual Type* visit(Times *n)=0;
  virtual Type* visit(ArrayLookup *n)=0;
  virtual Type* visit(ArrayLength *n)=0;
  virtual Type* visit(Call *n)=0;
  virtual Type* visit(IntegerLiteral *n)=0;
  virtual Type* visit(True *n)=0;
  virtual Type* visit(False *n)=0;
  virtual Type* visit(IdentifierExp *n)=0;
  virtual Type* visit(This *n)=0;
  virtual Type* visit(NewArray *n)=0;
  virtual Type* visit(NewObject *n)=0;
  virtual Type* visit(Not *n)=0;
  virtual Type* visit(Identifier *n)=0;
};

/* ===========================[Abstract classes]============================== */
class Exp {
public:
    virtual ~Exp() {}
    virtual void accept(Visitor *v)=0;
    virtual Type* accept(TypeVisitor *v)=0;
};
class Statement {
public:
    virtual ~Statement() { }
    virtual void accept(Visitor *v)=0;
    virtual Type* accept(TypeVisitor *v)=0;
};
class Type {
public:
    virtual ~Type() { }
    virtual void accept(Visitor *v)=0;
    virtual Type* accept(TypeVisitor *v)=0;
};
class ClassDecl {
public:
    virtual ~ClassDecl() { }
    virtual void accept(Visitor *v)=0;
    virtual Type* accept(TypeVisitor *v)=0;
};

/* ===========================[ListType classe]============================== */

template <typename T, template <typename> class IteratorType>
class ListTypeClass {
private:
  typedef std::deque<T*> list_t;
  list_t m_list;
  IteratorType<list_t> m_insert_itr;
public:
  ListTypeClass() : m_list(), m_insert_itr(m_list) { }
  inline void addElement(T *n) { *m_insert_itr++ = n; }
  inline T *elementAt(int i) const { return m_list[i]; }
  inline size_t size() const { return m_list.size(); }
};

//Defined types moved to parser.y
typedef ListTypeClass<ClassDecl, std::back_insert_iterator>  ClassDeclList;
typedef ListTypeClass<MethodDecl, std::back_insert_iterator> MethodDeclList;
typedef ListTypeClass<Exp, std::back_insert_iterator>        ExpList;
typedef ListTypeClass<Formal, std::back_insert_iterator>     FormalList;
typedef ListTypeClass<VarDecl, std::back_insert_iterator>    VarDeclList;
typedef ListTypeClass<Statement, std::front_insert_iterator> StatementList;

/* ===========================[Type classes]============================== */
class And : public Exp {
public:
    Exp *e1, *e2;
public:
  And( Exp *e1,  Exp *e2) : e1(e1), e2(e2){  }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class ArrayAssign : public Statement {
private:
public:
  Identifier *i;
  Exp *e1, *e2;
public:
  ArrayAssign( Identifier *ai,  Exp *ae1,  Exp *ae2) : i(ai), e1(ae1), e2(ae2){  }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class ArrayLength : public Exp {
private:
public:
  Exp *e;
public:
  ArrayLength( Exp *ae) : e(ae) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class ArrayLookup : public Exp {
private:
public:
  Exp *e1, *e2;
public:
  ArrayLookup( Exp *ae1,  Exp *ae2) : e1(ae1),  e2(ae2) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class Assign : public Statement {
private:
public:
  Identifier *i;
  Exp *e;

public:
  Assign( Identifier *ai,  Exp *ae) : i(ai), e(ae) {  }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class Block : public Statement {
private:
public:
  StatementList *sl;

public:
  Block( StatementList *asl) : sl(asl) {  }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class BooleanType : public Type {
public:
  inline bool equals(BooleanType *t){ return true; }
  template <typename T> inline bool equals(T *tp) { return false; }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class Call : public Exp {
private:
public:
  Exp *e;
  Identifier *i;
  ExpList *el;
public:
  Call( Exp *ae,  Identifier *ai,  ExpList *ael) : e(ae), i(ai), el(ael) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class ClassDeclExtends : public ClassDecl {
private:
public:
  Identifier *i, *j;
  VarDeclList *vl;
  MethodDeclList *ml;
public:
  ClassDeclExtends( Identifier *ai,  Identifier *aj,  VarDeclList *avl,  MethodDeclList *aml)
    : i(ai), j(aj), vl(avl), ml(aml) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class ClassDeclSimple : public ClassDecl {
private:
public:
  Identifier *i;
  VarDeclList *vl;  
  MethodDeclList *ml;
public:
  ClassDeclSimple( Identifier *ai,  VarDeclList *avl,  MethodDeclList *aml) : i(ai), vl(avl), ml(aml) {  }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class False : public Exp {
public:
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class Formal {
private:
public:
  Type *t;
  Identifier *i; 
public:
  Formal( Type *at,  Identifier *ai) : t(at), i(ai) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class Identifier {
private:
public:
  std::string s;
public:
  Identifier( std::string &as) : s(as) { }
  Identifier(const char *sz) : s(sz) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
  inline std::string toString(){ return s; }
};

class IdentifierExp : public Exp {
private:
public:
  std::string s;
public:
  IdentifierExp( std::string &as) : s(as) { }
  IdentifierExp (const char *sz) : s(sz) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class IdentifierType : public Type {
private:
public:
  std::string s;
public:
  IdentifierType( std::string &as) : s(as) { }
  inline bool equals(IdentifierType &t){ return t.s == s; }
  template <typename T> inline bool equals(T &tp) { return false; }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class If : public Statement {
private:
public:
  Exp *e;
  Statement *s1, *s2;
public:
  If( Exp *ae,  Statement *as1,  Statement *as2) : e(ae), s1(as1), s2(as2) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class IntArrayType : public Type {
public:
  inline bool equals(IntArrayType &t){ return true; }
  template <typename T> inline bool equals(T &tp) { return false; }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class IntegerLiteral : public Exp {
private:
public:
  int i;
public:
  IntegerLiteral(int ai) : i(ai) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class IntegerType : public Type {
public:
  inline bool equals(IntegerType &t){ return true; }
  template <typename T> inline bool equals(T &tp) { return false; }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class LessThan : public Exp {
private:
public:
  Exp *e1, *e2;
public:
  LessThan( Exp *ae1,  Exp *ae2) : e1(ae1), e2(ae2) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class MainClass {
private:
public:
	Identifier *i1, *i2;
	Statement *s;
public:
	MainClass( Identifier *ai1,  Identifier *ai2,  Statement *as) : i1(ai1), i2(ai2), s(as) { }
    inline void accept(Visitor *v) { v->visit(this); }
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class MethodDecl {
private:
public:
	Type *t;
	Identifier *i;
	FormalList *fl;
	VarDeclList *vl;
	StatementList *sl;
	Exp *e;
public:
	MethodDecl( Type *at,  Identifier *ai,  FormalList *afl,  VarDeclList *avl,  StatementList *asl,  Exp *ae) 
   : t(at), i(ai), fl(afl), vl(avl), sl(asl), e(ae){	}
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class Minus : public Exp {
private:
public:
	Exp *e1, *e2;
public:
	Minus( Exp *ae1,  Exp *ae2): e1(ae1), e2(ae2) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class NewArray : public Exp {
private:
public:
  Exp *e;
public: 
  NewArray( Exp *ae) : e(ae) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class NewObject : public Exp {
private:
public:
	Identifier *i;
public:
	NewObject( Identifier *ai) : i(ai) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class Not : public Exp {
private: 
public:
	Exp *e;
public :
	Not( Exp *ae) : e(ae) {	}
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class Plus : public Exp {
private:
public:
	Exp *e1, *e2;
public:
  Plus( Exp *ae1,  Exp *ae2) : e1(ae1), e2(ae2) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class Print : public Statement {
private:
public:
	Exp *e;
public:
	Print( Exp *ae) : e(ae) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class Program {
private:
public:
	MainClass *m;
	ClassDeclList *cl;
public:
	Program( MainClass *am,  ClassDeclList *acl) : m(am), cl(acl) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class This : public Exp {
public:
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class Times : public Exp {
private:
public:
	Exp *e1, *e2;
public:
	Times( Exp *ae1,  Exp *ae2) : e1(ae1), e2(ae2) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class True : public Exp {
public:
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class VarDecl {
private:
public:
  Type *t;
  Identifier *i;
public:
  VarDecl( Type *at,  Identifier *ai) : t(at), i(ai) { 	}
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

class While : public Statement {
private:
public:
  Exp *e;
  Statement *s;  
public:
  While( Exp *ae,  Statement *as) : e(ae), s(as) { }
  inline void accept(Visitor *v) { v->visit(this); }
  inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

#endif
