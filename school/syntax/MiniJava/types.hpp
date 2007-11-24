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

/**
 * @class	Visitor
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Abstract base class for visitors. This class provides methods that
 *			doesn't returns values.
 */
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

/**
 * @class	TypeVisitor
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Abstract base class for type visitors. This class provides methods that
 *			returns Type*.
 */
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
/**
 * @class	Exp
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Abstract base class for expressions
 */
class Exp {
public:
    /**
     * @fn		~Exp()
     * @brief	virtual destructor
     */
    virtual ~Exp() {}
    /**
     * @fn		virtual void accept(Visitor *v)=0
	 * @param	v the visitor to accept
     * @brief	pure virtual accept method
     */
	virtual void accept(Visitor *v)=0;
	
	/**
     * @fn		virtual Type* accept(TypeVisitor *v)=0
	 * @param	v the visitor to accept
	 * @return	type of the accepted visitor
     * @brief	pure virtual accept method
     */
    virtual Type* accept(TypeVisitor *v)=0;
};

/**
 * @class	Statement
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Abstract base class for statements
 */
class Statement {
public:
	/**
     * @fn		~Statement()
     * @brief	virtual destructor
     */
    virtual ~Statement() { }

	/**
     * @fn		virtual void accept(Visitor *v)=0
	 * @param	v the visitor to accept
     * @brief	pure virtual accept method
     */
    virtual void accept(Visitor *v)=0;

	/**
     * @fn		virtual Type* accept(TypeVisitor *v)=0
	 * @param	v the visitor to accept
	 * @return	type of the accepted visitor
     * @brief	pure virtual accept method
     */
	virtual Type* accept(TypeVisitor *v)=0;
};

/**
 * @class	Type
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Abstract base class for types
 */
class Type {
public:
	 /**
     * @fn		~Type()
     * @brief	virtual destructor
     */
    virtual ~Type() { }
	/**
     * @fn		virtual void accept(Visitor *v)=0
	 * @param	v the visitor to accept
	 * @return	type of the accepted visitor
     * @brief	pure virtual accept method
     */
    virtual void accept(Visitor *v)=0;
	/**
     * @fn		virtual Type* accept(TypeVisitor *v)=0
	 * @param	v the visitor to accept
	 * @return	type of the accepted visitor
     * @brief	pure virtual accept method
     */
    virtual Type* accept(TypeVisitor *v)=0;
	/**
     * @fn		std::string to_string()
	 * @return	the name of the type as a string
     * @brief	pure virtual to_string method.
     */
	virtual std::string to_string()=0;
};

/**
 * @class	ClassDecl
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Abstract base class for class declarations
 */
class ClassDecl {
public:
	/**
     * @fn		~ClassDecl()
     * @brief	virtual destructor
     */
    virtual ~ClassDecl() { }
	/**
     * @fn		virtual void accept(Visitor *v)=0
	 * @param	v the visitor to accept
	 * @return	type of the accepted visitor
     * @brief	pure virtual accept method
     */
    virtual void accept(Visitor *v)=0;
	/**
     * @fn		virtual Type* accept(TypeVisitor *v)=0
	 * @param	v the visitor to accept
	 * @return	type of the accepted visitor
     * @brief	pure virtual accept method
     */
    virtual Type* accept(TypeVisitor *v)=0;
};

/* ===========================[ListType classe]============================== */
/**
 * @class	ListTypeClass
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Template base class for diffrent listtypes. IteratorType defines where and in what
 *			order to insert into the list.
 */
template <typename T, template <typename> class IteratorType>
class ListTypeClass {
private:
    typedef std::deque<T*> list_t;
    list_t m_list;
    IteratorType<list_t> m_insert_itr;
public:
	/**
	 * @fn		ListTypeClass()
	 * @brief	Default constructor, sets up the list.
	 */
    ListTypeClass() : m_list(), m_insert_itr(m_list) { }
	
	/**
	 * @fn		~ListTypeClass()
	 * @brief	Default destructor, deletes all elements in list.
	 */
    ~ListTypeClass() {
		for (typename list_t::iterator itr = m_list.begin(); itr != m_list.end(); ++itr)
			delete *itr;
    }

	/**
	 * @fn		void addElement(T *n)
	 * @param	n the element to add
	 * @brief	adds one element to the list, into the place specified by InputIterator.
	 */
    inline void addElement(T *n) { *m_insert_itr++ = n; }
	
	/**
	 * @fn		T *elementAt(int i) const 
	 * @param	i the indexposition of the element aimed at
	 * @return	the element at position i int the list.
	 * @brief	Returns the element at index i in the list.
	 */
    inline T *elementAt(int i) const { return m_list[i]; }

	/**
	 * @fn		size_t size() const
	 * @return	the current size of the list
	 * @brief	Returns the current size of the list.
	 */
    inline size_t size() const { return m_list.size(); }
    
    typedef typename list_t::iterator iterator;
    typedef typename list_t::const_iterator const_iterator;

    const_iterator begin() { return m_list.begin(); }
    const_iterator end() { return m_list.end(); }
};

//Defined types moved to parser.y
typedef ListTypeClass<ClassDecl, std::back_insert_iterator>  ClassDeclList;
typedef ListTypeClass<MethodDecl, std::back_insert_iterator> MethodDeclList;
typedef ListTypeClass<Exp, std::back_insert_iterator>        ExpList;
typedef ListTypeClass<Formal, std::front_insert_iterator>     FormalList;
typedef ListTypeClass<VarDecl, std::back_insert_iterator>    VarDeclList;
typedef ListTypeClass<Statement, std::front_insert_iterator> StatementList;

/* ===========================[Type classes]============================== */
/**
 * @class	Identifier
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Class defining an identifier by a string.
 */
class Identifier {
public:
    std::string s;
	/**
	 * @fn		Identifier(std::string &as)
	 * @param	as the identifier to set the string s to
	 * @brief	Constructor for identifiers using std::string
	 */
    Identifier(std::string &as) : s(as) { }

	/**
	 * @fn		Identifier(const char *sz)
	 * @param	sz the identifier to set the string s to
	 * @brief	Constructor for identifiers using regular c-type string.
	 */
    Identifier(const char *sz) : s(sz) { }

	/**
	 * @fn		~Identifier()
	 * @brief	Empty default destructor.
	 */
    ~Identifier() { }

	/**
	 * @fn		accept(Visitor *v)
	 * @param	v the visitor to visit with this identifier
	 * @brief	Visits v with this identifier as argument.
	 * @see		class Visitor
	 */
    inline void accept(Visitor *v) { v->visit(this); }

	/**
	 * @fn		accept(Visitor *v)
	 * @param	v the visitor to visit with this identifier
	 * @return	returns the type returned by v->visit
	 * @brief	Visits v with this identifier as argument.
	 * @see		class TypeVisitor
	 */
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
    
	/**
	 * @fn		std::string toString()
	 * @return	the identifier as a std::string
	 * @brief	Returns the identifier as a string.
	 */
	inline std::string toString(){ return s; }
};

/**
 * @class	And
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Binary expresion that inherits Exp.
 * @see		class Exp
 */
class And : public Exp {
public:
    Exp *e1, *e2;

	/**
	 * @fn		And( Exp *e1,  Exp *e2)
	 * @param	e1 expresion 1 to set e1 to
	 * @param	e2 expresion 2 to set e2 to
	 * @brief	Constructor takeing 2 expresions.
	 */
    And( Exp *e1,  Exp *e2) : e1(e1), e2(e2){  }

	/**
	 * @fn		~And()
	 * @brief	Destructor deleteing the two expresions.
	 */
    ~And() { delete e1; delete e2; }

	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v the visitor to visit the and expression with.
	 * @brief	Visits v with this and expression as argument.
	 * @see		class Visitor
	 */
    inline void accept(Visitor *v) { v->visit(this); }
    
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v the visitor to visit the and expression with.
	 * @brief	Visits v with this and expression as argument.
	 * @see		class TypeVisitor
	 */
	inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	ArrayAssign 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Assigning array element that inherits Statement.
 */
class ArrayAssign : public Statement {
public:
    Identifier *i;
    Exp *e1, *e2;

	/**
	 * @fn		ArrayAssign( Identifier *ai,  Exp *ae1,  Exp *ae2)
	 * @param	ai the name of the array
	 * @param	ae1 the index of where to assign value of ae2
	 * @param	ae2 the value to assign at index ae1
	 * @brief	Constructor takeing name, index and value, ex. ai[ae1] = ae2;. 
	 */
    ArrayAssign( Identifier *ai,  Exp *ae1,  Exp *ae2) : i(ai), e1(ae1), e2(ae2){  }

    /**
	 * @fn		~ArrayAssign()
	 * @brief	Destructor deleteing arrayname, index and value (i, e1, e2).
	 */
	~ArrayAssign() { delete i; delete e1; delete e2; }
	
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v the visitor to visit the ArrayAssign with
	 * @brief	visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
    
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v the visitor to visit the ArrayAssign with
	 * @return	the value returned from v->visit
	 * @brief	visits v with this.
	 * @see		class TypeVisitor
	 */
	inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	ArrayLength 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	symbolizing .lenght() on an java style array, inherits Exp.
 * @see		class Exp
 */
class ArrayLength : public Exp {
public:
    Exp *e;
	/**
	 * @fn		ArrayLength( Exp *ae)
	 * @param	ae the name of the array
	 * @brief	Constructor takeing name of array to get length() on.
	 */
    ArrayLength( Exp *ae) : e(ae) { }

    /**
	 * @fn		~ArrayLength()
	 * @brief	Destructor deleting the name.
	 */
	~ArrayLength() { delete e; }

	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
	inline void accept(Visitor *v) { v->visit(this); }

	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
	inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	ArrayLookup 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	symbolizing value returend by array[x];
 * @see		class Exp
 */
class ArrayLookup : public Exp {
public:
    Exp *e1, *e2;
	/**
	 * @fn		ArrayLookup( Exp *ae1,  Exp *ae2)
	 * @param	ae1 the name of the array
	 * @param	ae2	the index of the value of intrest
	 * @brief	Constructor takeing name and index of array to valueAt from.
	 */
    ArrayLookup( Exp *ae1,  Exp *ae2) : e1(ae1),  e2(ae2) { }

	/**
	 * @fn		~ArrayLookup()
	 * @brief	Destructor deleting name and index.
	 */
    ~ArrayLookup() { delete e1; delete e2; }

	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	Assign 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	symbolizing assigment.
 * @see		class Statement
 */
class Assign : public Statement {
public:
	Identifier *i;
	Exp *e;

	/**
	 * @fn		Assign( Identifier *ai,  Exp *ae)
	 * @param	ai the identifier to assign to
	 * @param	ae the expression to assign
	 * @brief	Constructor taking an identifier to assign an expression to.
	 */
    Assign( Identifier *ai,  Exp *ae) : i(ai), e(ae) {  }

	/**
	 * @fn		~Assign()
	 * @brief	Destructor deleting identifier and expression.
	 */
    ~Assign() { delete i; delete e; }

	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	Block 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	symbolizing a list of statements;
 * @see		class Statement
 */
class Block : public Statement {
private:
public:
  StatementList *sl;
public:
	/**
	 * @fn		Block( StatementList *asl)
	 * @param	asl the list of statements
	 * @brief	Constructor taking an list of statements.
	 */
    Block( StatementList *asl) : sl(asl) {  }

	/**
	 * @fn		~Block()
	 * @brief	Destructor deleteing the statement list.
	 */
    ~Block() { delete sl; }
    
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	BooleanType 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	symbolizing a boolean type.
 * @see		class Type
 */
class BooleanType : public Type {
public:
	/**
	 * @fn		bool equals(BooleanType *t)
	 * @return	returns true
	 * @brief	predefined function returning true for booleans.
	 */
	inline bool equals(BooleanType *t){ return true; }

	/**
	 * @fn		bool equals(T *tp)
	 * @return	returns false
	 * @brief	predefined function returning false for all types but booleans.
	 */
	template <typename T> inline bool equals(T *tp) { return false; }
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
   	/**
     * @fn		std::string to_string()
	 * @return	the string "boolean"
     * @brief	a simple conversion to string method.
     */
    std::string to_string() { return std::string("boolean"); }
};

/**
 * @class	Call 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	symbolizing a method call.
 * @see		class Exp
 */
class Call : public Exp {
private:
public:
  Exp *e;
  Identifier *i;
  ExpList *el;
public:
	/**
	 * @fn		Call( Exp *ae,  Identifier *ai,  ExpList *ael)
	 * @param	ae the expression that the call is made on
	 * @param	ai the name of the call
	 * @param	ael the arguments provided for the call
	 * @brief	Constructor building an method call.
	 */
	Call( Exp *ae,  Identifier *ai,  ExpList *ael) : e(ae), i(ai), el(ael) { }

	/**
	 * @fn		~Call()
	 * @brief	Destructor deleteing expresion, identifier and the expressionlist.
	 */
	~Call() { delete e; delete i; delete el; }
    
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	ClassDeclExtends 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Not implemented! This takes care of classes that extend other classes.
 * @see		class ClassDecl
 */
class ClassDeclExtends : public ClassDecl {
private:
public:
  Identifier *i, *j;
  VarDeclList *vl;
  MethodDeclList *ml;
public:
	/**
	 * @fn		ClassDeclExtends( Identifier *ai,  Identifier *aj,  VarDeclList *avl,  MethodDeclList *aml)
	 * @param	ai the class identifier
	 * @param	aj the heritance identifier
	 * @param	avl variable declarations
	 * @param	aml method declarations
	 * @brief	Constructor for classes that uses the extends keyword.
	 */	
    ClassDeclExtends( Identifier *ai,  Identifier *aj,  VarDeclList *avl,  MethodDeclList *aml)
	: i(ai), j(aj), vl(avl), ml(aml) { }
    
	/**
	 * @fn		~ClassDeclExtends()
	 * @brief	Desctructor deleting identifiers, variable declarations and the method declaration list.
	 */
	~ClassDeclExtends() { delete i; delete j; delete vl; delete ml; }
	
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	ClassDeclSimple 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	A simple class declaration, that doesn't extend another class.
 * @see		class ClassDecl
 */
class ClassDeclSimple : public ClassDecl {
private:
public:
  Identifier *i;
  VarDeclList *vl;  
  MethodDeclList *ml;
public:

	/**
	 * @fn		ClassDeclSimple( Identifier *ai,  VarDeclList *avl,  MethodDeclList *aml)
	 * @param	ai the class identifier
	 * @param	avl variable declarations
	 * @param	aml method declarations
	 * @brief	Constructor for classes.
	 */	
    ClassDeclSimple( Identifier *ai,  VarDeclList *avl,  MethodDeclList *aml) : i(ai), vl(avl), ml(aml) {  }
    
	/**
	 * @fn		~ClassDeclSimple()
	 * @brief	Destructor that deletes all allocated member fields.
	 */
	~ClassDeclSimple() { delete i; delete vl; delete ml; }
	
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	False 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Boolean false expression.
 * @see		class Exp
 */
class False : public Exp {
public:
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
	inline void accept(Visitor *v) { v->visit(this); }
	
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */  
	inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	Formal 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	an element in a argument list.
 */
class Formal {
private:
public:
  Type *t;
  Identifier *i; 
public:
	/**
	 * @fn		Formal( Type *at,  Identifier *ai)
	 * @param	at the type of the element
	 * @param	ai the name of the element
	 * @brief	Constructor takeing the type and name of the element.
	 */
    Formal( Type *at,  Identifier *ai) : t(at), i(ai) { }

	/**
	 * @fn		~Formal()
	 * @brief	Destructor deleteing the type, and identifier.
	 */
    ~Formal() { delete t; delete i; }

	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	IdentifierExp 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	An identifier of an expression, using a string as name.
 * @see		Exp
 */
class IdentifierExp : public Exp {
public:
  std::string s;

	/**
	 * @fn		IdentifierExp( std::string &as)
	 * @param	as an std::string to set the name of the identifier
	 * @brief	Constructor that takes a std::string as argument.
	 */
	IdentifierExp( std::string &as) : s(as) { }
	
	/**
	 * @fn		IdentifierExp (const char *sz)
	 * @param	sz an regular c-string that set the name of the identifier
	 * @brief	Constructor that takes a regular c-string as argument.
	 */
	IdentifierExp (const char *sz) : s(sz) { }
	
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	IdentifierType 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	An identifier of an type.
 * @see		Type
 */
class IdentifierType : public Type {
public:
	std::string s;
	
	/**
	 * @fn		IdentifierType( const std::string &as)
	 * @param	as the name of the identifier
	 * @brief	sets the identifier of the type.
	 */
	IdentifierType( const std::string &as) : s(as) { }

	/**
	 * @fn		bool equals(IdentifierType &t)
	 * @param	t the IdentifierType to compare with
	 * @return	true if the names are equal
	 * @brief	compares 2 IdentifierTypes.
	 */
	inline bool equals(IdentifierType &t){ return t.s == s; }

	/**
	 * @fn		inline bool equals(T &tp)
	 * @return	false
	 * @brief	Function that returns false for all other types than IdentifierType.
	 */
	template <typename T> inline bool equals(T &tp) { return false; }
	
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
   	/**
     * @fn		std::string to_string()
	 * @return	the name of the identifier
     * @brief	a simple conversion to string method.
     */
    std::string to_string() { return s; }
};

/**
 * @class	If 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	A if/else statement.
 * @see		Statement
 */
class If : public Statement {
public:
  Exp *e;
  Statement *s1, *s2;

	/**
	 * @fn		If( Exp *ae,  Statement *as1,  Statement *as2)
	 * @param	ae the expression evaluated by the if-statment
	 * @param	as1 the statment that occures if the ae is true
	 * @param	as2 the else statement
	 * @brief	Constructor takeing an expression to be evaluated, and the statements to go if true and false.
	 */
    If( Exp *ae,  Statement *as1,  Statement *as2) : e(ae), s1(as1), s2(as2) { }

	/**
	 * @fn		~If()
	 * @brief	Destructor deleteing teh expression and the statements.
	 */
    ~If() { delete e; delete s1; delete s2; }
	
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	IntArrayType 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	An array of ints.
 * @see		Type
 */
class IntArrayType : public Type {
public:
	/**
	 * @fn		bool equals(IntArrayType &t)
	 * @return	true
	 * @brief	returns true if the type is IntArray.
	 */
	inline bool equals(IntArrayType &t){ return true; }

	/**
	 * @fn		bool equals(T &tp)
	 * @return	false
	 * @brief	returns false for all types but IntArray.
	 */
	template <typename T> inline bool equals(T &tp) { return false; }
	
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }

	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
   	/**
     * @fn		std::string to_string()
	 * @return	the string "int[]"
     * @brief	a simple conversion to string method.
     */
    std::string to_string() { return std::string("int[]"); }
};

/**
 * @class	IntegerLiteral 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	A integer literal.
 * @see		Exp
 */
class IntegerLiteral : public Exp {
public:
	int i;

	/**
	 * @fn		IntegerLiteral(int ai)
	 * @param	ai the int
	 * @brief	Constructor taking an int.
	 */
	IntegerLiteral(int ai) : i(ai) { }
	
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }

	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	IntegerType 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	The integer type.
 * @see		Type
 */
class IntegerType : public Type {
public:
	/**
	 * @fn		bool equals(IntegerType &t)
	 * @return	true
	 * @brief	returns true if the type is IntegerType.
	 */
	inline bool equals(IntegerType &t){ return true; }

	/**
	 * @fn		bool equals(T &tp)
	 * @return	false
	 * @brief	returns false for all types but IntegerType.
	 */
	template <typename T> inline bool equals(T &tp) { return false; }

	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
	inline void accept(Visitor *v) { v->visit(this); }

	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */ 
	inline Type* accept(TypeVisitor *v) { return v->visit(this); }
   	/**
     * @fn		std::string to_string()
	 * @return	the string "int"
     * @brief	a simple conversion to string method.
     */
    std::string to_string() { return std::string("int"); }
};

/**
 * @class	LessThan 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	A less than expression.
 * @see		Exp
 */
class LessThan : public Exp {
private:
public:
  Exp *e1, *e2;
public:
	/**
	 * @fn		LessThan( Exp *ae1,  Exp *ae2)
	 * @param	ae1 the left expression 
	 * @param	ae2 the right expression
	 * @brief	Constructor taking 2 expressions for evalueation.
	 */
    LessThan( Exp *ae1,  Exp *ae2) : e1(ae1), e2(ae2) { }

	/**
	 * @fn		~LessThan()
	 * @brief	Destructor deleteing the 2 expressions.
	 */
    ~LessThan() { delete e1; delete e2; }

	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }

	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */ 
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	MainClass 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	symbolizes a mainclass.
 */
class MainClass {
private:
public:
    Identifier *i1, *i2;
    Statement *s;
public:
	/**
	 * @fn		MainClass( Identifier *ai1,  Identifier *ai2,  Statement *as)
	 * @param	ai1 the name of the class
	 * @param	ai2	name of the argument of String[] 
	 * @param	as the statement inside public static void main
	 * @brief	a minijava main class.
	 */
	MainClass( Identifier *ai1,  Identifier *ai2,  Statement *as) : i1(ai1), i2(ai2), s(as) { }

	/**
	 * @fn		~MainClass()
	 * @brief	Destructor deleteing all allocated members.
	 */
    ~MainClass() { delete i1; delete i2; delete s; }

	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	MethodDecl 
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	A method declaration.
 */
class MethodDecl {
public:
	Type *t;
	Identifier *i;
	FormalList *fl;
	VarDeclList *vl;
	StatementList *sl;
	Exp *e;

	/**
	 * @fn		MethodDecl( Type *at,  Identifier *ai,  FormalList *afl,  VarDeclList *avl,  StatementList *asl,  Exp *ae)
	 * @param	at return type of method
	 * @param	ai the name of the method
	 * @param	afl the arguments taken by method
	 * @param	avl locals declared in method
	 * @param	asl	list of statements in method
	 * @param	ae value returned by method
	 * @brief	Constructor for a minijava method declaration.
	 */
	MethodDecl( Type *at,  Identifier *ai,  FormalList *afl,  VarDeclList *avl,  StatementList *asl,  Exp *ae) 
	: t(at), i(ai), fl(afl), vl(avl), sl(asl), e(ae){	}
    
	/**
	 * @fn		~MethodDecl()
	 * @brief	Destructor deleteing all allocated members.
	 */
	~MethodDecl() { delete t; delete i; delete fl; delete vl; delete sl; delete e; }
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	Minus
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	A minus expression.
 * @see		Exp
 */
class Minus : public Exp {
public:
	Exp *e1, *e2;

	/**
	 * @fn		Minus( Exp *ae1,  Exp *ae2)
	 * @param	ae1 the left hand expression
	 * @param	ae2	the right hand expression
	 * @brief	Constructor for a minius expression.
	 */
	Minus( Exp *ae1,  Exp *ae2): e1(ae1), e2(ae2) { }
	
	/**
	 * @fn		~Minus()
	 * @brief	Destructor deleteing all allocated members.
	 */
    ~Minus() { delete e1; delete e2; }

    /**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	NewArray
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	An allocation of an array expression.
 * @see		Exp
 */
class NewArray : public Exp {
public:
	Exp *e;
    /**
	 * @fn		NewArray( Exp *ae)
	 * @param	ae the expression (often a number) of elements.
	 * @brief	Constructor for a new array expression.
	 */
	NewArray( Exp *ae) : e(ae) { }

	/**
	 * @fn		~NewArray()
	 * @brief	Destructor deleteing all allocated members.
	 */
    ~NewArray() { delete e; }
    
	/**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	NewObject
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	symbolizing the new keyword.
 * @see		Exp
 */
class NewObject : public Exp {
public:
    Identifier *i;
	/**
	 * @fn		NewObject( Identifier *ai)
	 * @param	ai the name of object to use new on
	 * @brief	Constructor of the new keyword.
	 */
    NewObject( Identifier *ai) : i(ai) { }
	/**
	 * @fn		~NewObject()
	 * @brief	Destructor deleteing all allocated members.
	 */
    ~NewObject() { delete i; }
    /**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	Not
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	symbolizing the not keyword.
 * @see		Exp
 */
class Not : public Exp {
public:
    Exp *e;
	/**
	 * @fn		Not( Exp *ae)
	 * @param	ae the expression to apply not to
	 * @brief	Constructor of a not expression.
	 */	
    Not( Exp *ae) : e(ae) {	}
	/**
	 * @fn		~Not()
	 * @brief	Destructor deleteing all allocated members.
	 */
    ~Not() { delete e; }
    /**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	Plus
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	An add expression.
 * @see		Exp
 */
class Plus : public Exp {
public:
    Exp *e1, *e2;
	/**
	 * @fn		Plus( Exp *ae1,  Exp *ae2)
	 * @param	ae1 the left hand expression
	 * @param	ae2 the right hand expression
	 * @brief	Constructor of a binary expression, representing add.
	 */	
	Plus( Exp *ae1,  Exp *ae2) : e1(ae1), e2(ae2) { }
	/**
	 * @fn		~Plus()
	 * @brief	Destructor deleteing all allocated members.
	 */
    ~Plus() { delete e1; delete e2; }
    /**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	Print
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	A print statement.
 * @see		Statement
 */
class Print : public Statement {
public:
    Exp *e;
	/**
	 * @fn		Print( Exp *ae)
	 * @param	ae the expression to be printed
	 * @brief	Constructor taking an expression to print.
	 */	
    Print( Exp *ae) : e(ae) { }
	/**
	 * @fn		~Print()
	 * @brief	Destructor deleteing all allocated members.
	 */
    ~Print() { delete e; }
    /**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	Program
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	A print statement.
 */
class Program {
public:
    MainClass *m;
    ClassDeclList *cl;
	/**
	 * @fn		Program( MainClass *am,  ClassDeclList *acl)
	 * @param	am the mainclass
	 * @param	acl the other classes
	 * @brief	Constructor of the whole program.
	 */	
	Program( MainClass *am,  ClassDeclList *acl) : m(am), cl(acl) { }
	/**
	 * @fn		~Program()
	 * @brief	Destructor deleteing all allocated members.
	 */
    ~Program() { delete m; delete cl; }
    /**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	This
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	The this keyword.
 */
class This : public Exp {
public:
    /**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	Times
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Binary times expression.
 * @see		Exp
 */
class Times : public Exp {
public:
    Exp *e1, *e2;

	/**
	 * @fn		Times( Exp *ae1,  Exp *ae2) 
	 * @param	ae1 the left hand expression
	 * @param	ae2 the right hand expresson
	 * @brief	Constructor for a binary times expression.
	 */	
	Times( Exp *ae1,  Exp *ae2) : e1(ae1), e2(ae2) { }
	/**
	 * @fn		~Times()
	 * @brief	Destructor deleteing all allocated members.
	 */
    ~Times() { delete e1; delete e2; }
    /**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	True
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	The true keyword.
 * @see		Exp
 */
class True : public Exp {
public:
    /**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	VarDecl
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	A variable declaration.
 */
class VarDecl {
public:
    Type *t;
    Identifier *i;

	/**
	 * @fn		VarDecl( Type *at,  Identifier *ai)
	 * @param	at the type of the variable
	 * @param	ai the name of the variable
	 * @brief	Constructor for variable declarations.
	 */
    VarDecl( Type *at,  Identifier *ai) : t(at), i(ai) { 	}
	/**
	 * @fn		~VarDecl()
	 * @brief	Destructor deleteing all allocated members.
	 */
    ~VarDecl() { delete t; delete i; }
    /**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

/**
 * @class	While
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	A while statement.
 * @see		Statement
 */
class While : public Statement {
public:
    Exp *e;
    Statement *s;  
	
	/**
	 * @fn		While( Exp *ae,  Statement *as)
	 * @param	ae the expression to be evaluated
	 * @param	as the statement to be run if ae is true
	 * @brief	Constructor for a while statement.
	 */
    While( Exp *ae,  Statement *as) : e(ae), s(as) { }
	/**
	 * @fn		~While()
	 * @brief	Destructor deleteing all allocated members.
	 */
    ~While() { delete e; delete s; }
    /**
	 * @fn		void accept(Visitor *v)
	 * @param	v visitor to visit this with
	 * @brief	Visits v with this.
	 */
    inline void accept(Visitor *v) { v->visit(this); }
	/**
	 * @fn		Type* accept(TypeVisitor *v)
	 * @param	v visitor to visit this with
	 * @return	the value returned by v->visit
	 * @brief	Visits v with this.
	 * @see		TypeVisitor
	 */    
    inline Type* accept(TypeVisitor *v) { return v->visit(this); }
};

#endif
