#ifndef _TCV_HPP_
#define _TCV_HPP_

#include "visitor.hpp"
#include "symbol_table.hpp"

/**
 * @class	cTcv
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Type check visitor.
 * @see		TypeDepthFirstVisitor
 */
class cTcv : public TypeDepthFirstVisitor {
private:
  std::string m_class, m_func;
  cSymbolTable &m_table;
public:
  /**
   * @fn		cTcv(cSymbolTable &t)
   * @param	t the symboltable to syntax check
   * @brief	Constructor takeing an symboltable to do syntax checking on.
   */
  cTcv(cSymbolTable &t) : m_class("none"), m_func("none"), m_table(t) { }
  
  /**
   * @fn		~cTcv()
   * @brief	a virtual destructor
   */
  virtual ~cTcv() { }
  
  /**
   * @fn		Type* visit(Program *n)
   * @param	n the Program to visit
   * @return	NULL
   * @brief	Checks the MainClass of the Program, then all other class declarations.
   */
  Type* visit(Program *n) {
    n->m->accept(this);
    for ( size_t i = 0; i < n->cl->size(); i++ ) {
      n->cl->elementAt(i)->accept(this);
    }
    return NULL;
  }
  
  /**
   * @fn		Type* visit(MainClass *n)
   * @param	n the MainClass to visit
   * @return	NULL
   * @brief	Sets current class to the MainClass's name, then 
   *			checks classname, argument name and statements. Resets
   *			the m_class to none on exit.
   */
  Type* visit(MainClass *n) {
    m_class = n->i1->s;
    
    n->i1->accept(this);
    n->i2->accept(this);
    n->s->accept(this);
    
    m_class = "none";
    return NULL;
  }
  
  
  /**
   * @fn		Type* visit(ClassDeclSimple *n)
   * @param	n the ClassDeclSimple to visit
   * @return	NULL
   * @brief	Sets current class to the ClassDeclSimple's identifier name, then 
   *			checks identifier, variable declarations and methods. Resets
   *			the m_class to none on exit.
   */
  Type* visit(ClassDeclSimple *n) {
    m_class = n->i->s;
    
    n->i->accept(this);
    for ( size_t i = 0; i < n->vl->size(); i++ ) {
      n->vl->elementAt(i)->accept(this);
    }
    for ( size_t i = 0; i < n->ml->size(); i++ ) {
      n->ml->elementAt(i)->accept(this);
    }
    
    m_class = "none";
    return NULL;
  }
  
  /**
   * @fn		Type* visit(ClassDeclExtends *n)
   * @param	n the ClassDeclExtends to visit
   * @return	NULL
   * @brief	Asserts! This is not correctly implemented!
   */
  
  
  Type* visit(ClassDeclExtends *n) {
    assert(0 && "ClassDeclExtends!!!");
    
    n->i->accept(this);
    n->j->accept(this);
    for ( size_t i = 0; i < n->vl->size(); i++ ) {
      n->vl->elementAt(i)->accept(this);
    }
    for ( size_t i = 0; i < n->ml->size(); i++ ) {
      n->ml->elementAt(i)->accept(this);
    }
    return NULL;
  }
  
  
  /**
   * @fn		Type* visit(VarDecl *n)
   * @param	n the VarDecl to visit
   * @return	the variable visited
   * @brief	Checks the type of the VarDecl and it's identifier.
   */
  Type* visit(VarDecl *n) {
    Type *t = n->t->accept(this);
    n->i->accept(this);
    return t;
  }
  
  
  
  /**
   * @fn		Type* visit(MethodDecl *n)
   * @param	n the MethodDecl to visit
   * @return	NULL
   * @brief	Sets m_func to n's function name. Then checks type, identifier, formallist, 
   *			variable declarations, statements and expressions. Then resets m_func to 
   *			"none" on exit.
   */
  Type* visit(MethodDecl *n) {
    m_func = n->i->s;
    
    Type *ret_type = n->t->accept(this);
    n->i->accept(this);
    for ( size_t i = 0; i < n->fl->size(); i++ ) {
      n->fl->elementAt(i)->accept(this);
    }
    for ( size_t i = 0; i < n->vl->size(); i++ ) {
      n->vl->elementAt(i)->accept(this);
    }
    for ( size_t i = 0; i < n->sl->size(); i++ ) {
      n->sl->elementAt(i)->accept(this);
    }
    
    Type *ret_exp = n->e->accept(this);
    /* Check the return expression. */
    if (ret_exp->to_string() != ret_type->to_string()) {
      printf("In: %s : Trying to return an expression of type: %s when the method is declared to return a: %s\n", m_func.c_str(), ret_exp->to_string().c_str(), ret_type->to_string().c_str());
      throw ("rocks");
    }
    
    m_func = "none";
    return NULL;
  }
  
  /**
   * @fn		Type* visit(Formal *n)
   * @param	n the Formal to visit
   * @return	the type of the Formal visited
   * @brief	Checks type and identifier of the Formal.
   */
  Type* visit(Formal *n) {
    Type *t = n->t->accept(this);
    n->i->accept(this);
    return t;
  }
  /**
   * @fn		Type* visit(IntArrayType *n)
   * @param	n the IntArrayType to visit
   * @return	the IntArrayType visited
   * @brief	returns n.
   */
  
  Type* visit(IntArrayType *n) {
    return n;
  }
  
  /**
   * @fn		Type* visit(BooleanType *n)
   * @param	n the BooleanType to visit
   * @return	the BooleanType visited
   * @brief	returns n.
   */
  Type* visit(BooleanType *n) {
    return n;
  }
  
  
  /**
   * @fn		Type* visit(IntegerType *n)
   * @param	n the IntegerType to visit
   * @return	the IntegerType visited
   * @brief	returns n.
   */
  Type* visit(IntegerType *n) {
    return n;
  }
  
  
  /**
   * @fn		Type* visit(IdentifierType *n)
   * @param	n the IdentifierType to visit
   * @return	the IdentifierType visited
   * @brief	returns n.
   */ 
  Type* visit(IdentifierType *n) {
    return n;
  }  
  /**
   * @fn		Type* visit(Block *n)
   * @param	n the Block to visit
   * @return	NULL
   * @brief	Checks all statements in statementlist.
   */ 
  Type* visit(Block *n) {
    for ( size_t i = 0; i < n->sl->size(); i++ ) {
      n->sl->elementAt(i)->accept(this);
    }
    return NULL;
  }
  
  /**
   * @fn		Type* visit(If *n)
   * @param	n the If to visit
   * @return	NULL
   * @brief	Checks expression and its 2 statments.
   */ 
  Type* visit(If *n) {
    Type *exp_type = n->e->accept(this);
    n->s1->accept(this);
    n->s2->accept(this);
    
    if (exp_type->to_string() != "boolean") {
      printf("Cannot use if with non boolean expression.\n");
      throw("rocks");
    }
    return NULL;
  }
  
  /**
   * @fn		Type* visit(While *n)
   * @param	n the While to visit
   * @return	NULL
   * @brief	Checks expression and statement.
   */ 
  Type* visit(While *n) {
    Type *exp_type = n->e->accept(this);
    n->s->accept(this);
    
    if (exp_type->to_string() != "boolean") {
      printf("Cannot use while with non boolean expression.\n");
      throw("rocks");
    }
    return NULL;
  }
  
  /**
   * @fn		Type* visit(Print *n)
   * @param	n the Print to visit
   * @return	NULL
   * @brief	Checks expression.
   */ 
  Type* visit(Print *n) {
    n->e->accept(this);
    return NULL;
  }
  /**
   * @fn		Type* visit(Assign *n)
   * @param	n the Assign to visit
   * @return	the final type
   * @throw	rocks
   * @brief	Checks type of left identifer against right hand side expression.
   */ 
  Type* visit(Assign *n) {
    n->i->accept(this);
    Type *t1 = m_table.get_var(m_class, m_func, n->i->s);
    Type *t2 = n->e->accept(this);
    assert(t1);
    if (!t2) {
      printf("n->i->s: %s\n", n->i->s.c_str());
      assert(t2);
    }
    if (t1->to_string() != t2->to_string()) {
      printf("Cannot assign variable of type: %s with value of type: %s\n", t1->to_string().c_str(), t2->to_string().c_str());
      throw ("rocks");
    }
    return t1;
  }
  
  /**
   * @fn		Type* visit(ArrayAssign *n)
   * @param	n the ArrayAssign to visit
   * @return	the final type
   * @throw	rocks
   * @brief	Checks type of left identifer against right hand side expression.
   */ 
  Type* visit(ArrayAssign *n) {
    Type *t1 = n->i->accept(this);
    Type *size = n->e1->accept(this);
    Type *t2 = n->e2->accept(this);
    
    if (!t1)
      t1 = m_table.get_var(m_class, m_func, n->i->s);
    
    assert(t1);
    assert(t2);
    
    if (t1->to_string() != "int[]") {
      printf("Arrays can only be of type int[]\n");
      throw ("rocks");
    }
    if (t2->to_string() != "int") {
      printf("Cannot assign index in array of type: %s with something of type: %s\n", t1->to_string().c_str(), t2->to_string().c_str());
      throw ("rocks");
    }
    if (size->to_string() != "int") {
      printf("Cannot access array index with non integer expression.\n");
      throw ("rocks");
    }
    return t1;
  }
  
  /**
   * @fn		Type* visit(And *n)
   * @param	n the And to visit
   * @return	the final type
   * @throw	rocks
   * @brief	Checks type of left identifer against right hand side expression.
   */ 
  
  Type* visit(And *n) {
    Type *t1 = n->e1->accept(this);
    Type *t2 = n->e2->accept(this);
    if (! (t1->to_string() == t2->to_string() && t1->to_string() == "boolean") ) {
      printf("Cannot do logocal AND on two non boolean expressions.\n");
      throw ("rocks");
    }
    return t1;
  }
  
  
  /**
   * @fn		Type* visit(LessThan *n)
   * @param	n the LessThan to visit
   * @return	the final type
   * @throw	rocks
   * @brief	Checks type of left identifer against right hand side expression.
   */ 
  Type* visit(LessThan *n) {
    Type *t1 = n->e1->accept(this);
    Type *t2 = n->e2->accept(this);
    static BooleanType b;
    if (! (t1->to_string() == t2->to_string() && t1->to_string() == "int") ) {
      printf("Cannot comapre two non integers.");
      throw ("rocks");
    }
    return &b;
  }
  
  
  /**
   * @fn		Type* visit(Plus *n)
   * @param	n the Plus to visit
   * @return	the final type
   * @throw	rocks
   * @brief	Checks type of left identifer against right hand side expression.
   */ 
  Type* visit(Plus *n) {
    Type *t1 = n->e1->accept(this);
    Type *t2 = n->e2->accept(this);
    if (! (t1->to_string() == t2->to_string() && t1->to_string() == "int") ) {
      printf("Cannot do plus two non integers. Op1 is of type: %s Op2 is of type: %s", t1->to_string().c_str(), t2->to_string().c_str());
      throw ("rocks");
    }
    return t1;
  }
  /**
   * @fn		Type* visit(Minus *n)
   * @param	n the Minus to visit
   * @return	the final type
   * @throw	rocks
   * @brief	Checks type of left identifer against right hand side expression.
   */   
  Type* visit(Minus *n) {
    Type *t1 = n->e1->accept(this);
    Type *t2 = n->e2->accept(this);
    IntegerType i;
    if (! (t1->to_string() == t2->to_string() && t1->to_string() == "int") ) {
      printf("Cannot do minus two non integers.");
      throw ("rocks");
    }
    return t1;
  }
  
  
  /**
   * @fn		Type* visit(Times *n)
   * @param	n the Times to visit
   * @return	the final type
   * @throw	rocks
   * @brief	Checks type of left identifer against right hand side expression.
   */ 
  Type* visit(Times *n) {
    Type *t1 = n->e1->accept(this);
    Type *t2 = n->e2->accept(this);
    IntegerType i;
    if (! (t1->to_string() == t2->to_string() && t1->to_string() == "int") ) {
      printf("Cannot multiply two non integers.");
      throw ("rocks");
    }
    return t1;
  }
  
  
  /**
   * @fn		Type* visit(ArrayLookup *n)
   * @param	n the ArrayLookup to visit
   * @return	NULL
   * @brief	Checks type of left identifer against right hand side expression.
   */ 
  Type* visit(ArrayLookup *n) {
    static IntegerType i;
    n->e1->accept(this);
    Type *t = n->e2->accept(this);
    if (t->to_string() != "int") {
      printf("Cannot access arrays with non integer index.\n");
      throw ("rocks");
    }
    return &i;
  }
  
  /**
   * @fn		Type* visit(ArrayLength *n)
   * @param	n the ArrayLength to visit
   * @return	NULL
   * @brief	Checks the expression in n.
   */ 
  Type* visit(ArrayLength *n) {
    static IntegerType i;
    n->e->accept(this);
    return &i;
  }
  
  /**
   * @fn		Type* visit(ArrayLength *n)
   * @param	n the ArrayLength to visit
   * @return	NULL
   * @brief	Checks the expression in n.
   */ 
  Type* visit(Call *n) {
    cSymbolTable::type_vec formals;
    Type *callee_type = n->e->accept(this);
    n->i->accept(this);
    for ( size_t i = 0; i < n->el->size(); i++ ) {
      Type *formal_type = n->el->elementAt(i)->accept(this);
      assert(formal_type);
      formals.push_back(formal_type->to_string());
    }
    assert(callee_type);
    
    return m_table.get_func(callee_type->to_string(), n->i->s, formals);
  }
  
  
  /**
   * @fn		Type* visit(IntegerLiteral *n)
   * @param	n the IntegerLiteral to visit
   * @return	an IntegerType*
   */ 
  Type* visit(IntegerLiteral *n) {
    static IntegerType i;
    return &i;
  }
  
  
  /**
   * @fn		Type* visit(True *n)
   * @param	n the True to visit
   * @return	an BooleanType*
   */ 
  Type* visit(True *n) {
    static BooleanType b;
    return &b;
  }
  
  
  /**
   * @fn		Type* visit(False *n)
   * @param	n the False to visit
   * @return	an BooleanType*
   */ 
  Type* visit(False *n) {
    static BooleanType b;
    return &b;
  }
  
  
  /**
   * @fn		Type* visit(IdentifierExp *n)
   * @param	n the IdentifierExp to visit
   * @return	an BooleanType*
   */ 
  Type* visit(IdentifierExp *n) {
    return m_table.get_var(m_class, m_func, n->s);
  }
  
  /**
   * @fn		Type* visit(This *n)
   * @param	n the This to visit
   * @return	an IdentifierType*
   */ 
  
  Type* visit(This *n) {
    return new IdentifierType(m_class);
  }
  
  /**
   * @fn		Type* visit(NewArray *n)
   * @param	n the NewArray to visit
   * @throw	rocks
   * @return	IntegerType*
   * @brief	Checks that the type of the array is of type int.
   */ 
  Type* visit(NewArray *n) {
    static IntArrayType i;
    Type *t = n->e->accept(this);
    if (t->to_string() != "int") {
      printf("Cannot use a non integer as expression for a \"new\" statement.\n");
      throw ("rocks");
    }
    return &i;
  }
  
  
  
  /**
   * @fn		Type* visit(NewObject *n)
   * @param	n the NewObject to visit
   * @throw	rocks
   * @return	IdentifierType*
   * @brief	return new IdentifierType.
   */ 
  Type* visit(NewObject *n) {
    return new IdentifierType(n->i->s);
  }
  
  
  /**
   * @fn		Type* visit(Not *n)
   * @param	n the Not to visit
   * @throw	rocks
   * @return	Type*
   * @brief	Checks that the expression is boolean.
   */ 
  Type* visit(Not *n) {
    Type *t = n->e->accept(this);
    if (t->to_string() != "boolean") {
      printf("Cannot do logical NOT on a non boolean.\n");
      throw ("rocks");
    }
    return t;
  }
  
  
  
  /**
   * @fn		Type* visit(Identifier *n)
   * @param	n the Identifier to visit
   * @return	value of m_table.get_var()
   */ 
  Type* visit(Identifier *n) {
    return NULL;
  }
};
  
#endif
