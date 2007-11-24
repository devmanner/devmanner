#ifndef _VISITOR_HPP_
#define _VISITOR_HPP_
#include "types.hpp"

/**
 * @class	DepthFirstVisitor
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Abstract class (not pure) that uses depth first to traverse.
 * @see		Visitor
 */
class DepthFirstVisitor : public Visitor {
public:
	/**
	 * @fn		void visit(Program *n)
	 * @param	n the Program to visit
	 * @brief	Program is devided into: a MainClass and ClassDeclList.
	 */
	virtual void visit(Program *n);

	/**
	 * @fn		void visit(MainClass *n)
	 * @param	n the MainClass to visit
	 * @brief	MainClass is devided into: 2 Identifiers and a Statement.
	 */
	virtual void visit(MainClass *n);

	/**
	 * @fn		void visit(ClassDeclSimple *n)
	 * @param	n the ClassDeclSimple to visit
	 * @brief	ClassDeclSimple is devided into: Identifier, VarDeclList and MethodDeclList.
	 */
	virtual void visit(ClassDeclSimple *n);

	/**
	 * @fn		void visit(ClassDeclExtends *n)
	 * @param	n the ClassDeclExtends to visit
	 * @brief	Not implemented! ClassDeclExtends is devided into: 2 Identifiers, VarDeclList and MethodDeclList.
	 */
	virtual void visit(ClassDeclExtends *n);

	/**
	 * @fn		void visit(VarDecl *n)
	 * @param	n the VarDecl to visit
	 * @brief	VarDecl is devided into: Type and Identifier.
	 */
	virtual void visit(VarDecl *n);

	/**
	 * @fn		void visit(MethodDecl *n)
	 * @param	n the MethodDecl to visit
	 * @brief	MethodDecl is devided into: Type*, Identifier, FormalList, VarDeclList, StatementList and Exp.
	 */
	virtual void visit(MethodDecl *n);

	/**
	 * @fn		void visit(Formal *n)
	 * @param	n the Formal to visit
	 * @brief	Formal is devided into: Type* and Identifier.
	 */
	virtual void visit(Formal *n);

	/**
	 * @fn		void visit(IntArrayType *n)
	 * @param	n the IntArrayType to visit
	 */
	virtual void visit(IntArrayType *n);

	/**
	 * @fn		void visit(BooleanType *n)
	 * @param	n the BooleanType to visit
	 */
	virtual void visit(BooleanType *n);

	/**
	 * @fn		void visit(IntegerType *n)
	 * @param	n the IntegerType to visit
	 */
	virtual void visit(IntegerType *n);

	/**
	 * @fn		void visit(IdentifierType *n)
	 * @param	n the IdentifierType to visit
	 * @brief	IdentifierType is devided into: string.
	 */
	virtual void visit(IdentifierType *n);

	/**
	 * @fn		void visit(Block *n)
	 * @param	n the Block to visit
	 * @brief	Block is devided into: StatementList.
	 */
	virtual void visit(Block *n);

	/**
	 * @fn		void visit(If *n)
	 * @param	n the If to visit
	 * @brief	If is devided into: Exp and Statement.
	 */
	virtual void visit(If *n);

	/**
	 * @fn		void visit(While *n)
	 * @param	n the While to visit
	 * @brief	While is devided into: Exp and Statement.
	 */
	virtual void visit(While *n);

	/**
	 * @fn		void visit(Print *n)
	 * @param	n the Print to visit
	 * @brief	Print is devided into: Exp.
	 */
	virtual void visit(Print *n);

	/**
	 * @fn		void visit(Assign *n)
	 * @param	n the Assign to visit
	 * @brief	Assign is devided into: Identifier and Exp.
	 */
	virtual void visit(Assign *n);

	/**
	 * @fn		void visit(ArrayAssign *n)
	 * @param	n the ArrayAssign to visit
	 * @brief	ArrayAssign is devided into: Identifier and 2 Exp.
	 */
	virtual void visit(ArrayAssign *n);

	/**
	 * @fn		void visit(And *n)
	 * @param	n the And to visit
	 * @brief	And is devided into: 2 Exp.
	 */
	virtual void visit(And *n);

	/**
	 * @fn		void visit(LessThan *n)
	 * @param	n the LessThan to visit
	 * @brief	LessThan is devided into: 2 Exp.
	 */
	virtual void visit(LessThan *n);

	/**
	 * @fn		void visit(Plus *n)
	 * @param	n the Plus to visit
	 * @brief	Plus is devided into: 2 Exp.
	 */
	virtual void visit(Plus *n);

	/**
	 * @fn		void visit(Minus *n)
	 * @param	n the Minus to visit
	 * @brief	Minus is devided into: 2 Exp.
	 */
	virtual void visit(Minus *n);

	/**
	 * @fn		void visit(Times *n)
	 * @param	n the Times to visit
	 * @brief	Times is devided into: 2 Exp.
	 */
	virtual void visit(Times *n);

	/**
	 * @fn		void visit(ArrayLookup *n)
	 * @param	n the ArrayLookup to visit
	 * @brief	ArrayLookup is devided into: 2 Exp.
	 */
	virtual void visit(ArrayLookup *n);

	/**
	 * @fn		void visit(ArrayLength *n)
	 * @param	n the ArrayLength to visit
	 * @brief	ArrayLength is devided into: Exp.
	 */
	virtual void visit(ArrayLength *n);

	/**
	 * @fn		void visit(Call *n)
	 * @param	n the Call to visit
	 * @brief	Call is devided into: Exp, Identifier and ExpList.
	 */
	virtual void visit(Call *n);

	/**
	 * @fn		void visit(IntegerLiteral *n)
	 * @param	n the IntegerLiteral to visit
	 * @brief	IntegerLiteral is devided into: int.
	 */
	virtual void visit(IntegerLiteral *n);

	/**
	 * @fn		void visit(True *n)
	 * @param	n the True to visit
	 */	
	virtual void visit(True *n);

	/**
	 * @fn		void visit(False *n)
	 * @param	n the False to visit
	 */	
	virtual void visit(False *n);

	/**
	 * @fn		void visit(IdentifierExp *n)
	 * @param	n the IdentifierExp to visit
	 * @brief	IdentifierExp is devided into: std::string.
	 */
	virtual void visit(IdentifierExp *n);

	/**
	 * @fn		void visit(This *n)
	 * @param	n the This to visit
	 */	
	virtual void visit(This *n);

	/**
	 * @fn		void visit(NewArray *n)
	 * @param	n the NewArray to visit
	 * @brief	NewArray is devided into: Exp.
	 */
	virtual void visit(NewArray *n);

	/**
	 * @fn		void visit(NewObject *n)
	 * @param	n the NewObject to visit
	 * @brief	NewObject is devided into: Identifier.
	 */
	virtual void visit(NewObject *n);

	/**
	 * @fn		void visit(Not *n)
	 * @param	n the Not to visit
	 * @brief	Not is devided into: Exp.
	 */
	virtual void visit(Not *n);

	/**
	 * @fn		void visit(Identifier *n)
	 * @param	n the Identifier to visit
	 * @brief	Identifier is devided into: std::string.
	 */
	virtual void visit(Identifier *n);
};


/**
 * @class	PrettyPrintVisitor
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Abstract class (not pure) that visits and provides a nice output.
 * @see		Visitor
 */
class PrettyPrintVisitor : public Visitor {
public:
	/**
	 * @fn		void visit(Program *n)
	 * @param	n the Program to visit
	 * @brief	Program is devided into: a MainClass and ClassDeclList.
	 */
	virtual void visit(Program *n);

	/**
	 * @fn		void visit(MainClass *n)
	 * @param	n the MainClass to visit
	 * @brief	MainClass is devided into: 2 Identifiers and a Statement.
	 */
	virtual void visit(MainClass *n);

	/**
	 * @fn		void visit(ClassDeclSimple *n)
	 * @param	n the ClassDeclSimple to visit
	 * @brief	ClassDeclSimple is devided into: Identifier, VarDeclList and MethodDeclList.
	 */
	virtual void visit(ClassDeclSimple *n);

	/**
	 * @fn		void visit(ClassDeclExtends *n)
	 * @param	n the ClassDeclExtends to visit
	 * @brief	Not implemented! ClassDeclExtends is devided into: 2 Identifiers, VarDeclList and MethodDeclList.
	 */
	virtual void visit(ClassDeclExtends *n);

	/**
	 * @fn		void visit(VarDecl *n)
	 * @param	n the VarDecl to visit
	 * @brief	VarDecl is devided into: Type and Identifier.
	 */
	virtual void visit(VarDecl *n);

	/**
	 * @fn		void visit(MethodDecl *n)
	 * @param	n the MethodDecl to visit
	 * @brief	MethodDecl is devided into: Type*, Identifier, FormalList, VarDeclList, StatementList and Exp.
	 */
	virtual void visit(MethodDecl *n);

	/**
	 * @fn		void visit(Formal *n)
	 * @param	n the Formal to visit
	 * @brief	Formal is devided into: Type* and Identifier.
	 */
	virtual void visit(Formal *n);

	/**
	 * @fn		void visit(IntArrayType *n)
	 * @param	n the IntArrayType to visit
	 */
	virtual void visit(IntArrayType *n);

	/**
	 * @fn		void visit(BooleanType *n)
	 * @param	n the BooleanType to visit
	 */
	virtual void visit(BooleanType *n);

	/**
	 * @fn		void visit(IntegerType *n)
	 * @param	n the IntegerType to visit
	 */
	virtual void visit(IntegerType *n);

	/**
	 * @fn		void visit(IdentifierType *n)
	 * @param	n the IdentifierType to visit
	 * @brief	IdentifierType is devided into: string.
	 */
	virtual void visit(IdentifierType *n);

	/**
	 * @fn		void visit(Block *n)
	 * @param	n the Block to visit
	 * @brief	Block is devided into: StatementList.
	 */
	virtual void visit(Block *n);

	/**
	 * @fn		void visit(If *n)
	 * @param	n the If to visit
	 * @brief	If is devided into: Exp and Statement.
	 */
	virtual void visit(If *n);

	/**
	 * @fn		void visit(While *n)
	 * @param	n the While to visit
	 * @brief	While is devided into: Exp and Statement.
	 */
	virtual void visit(While *n);

	/**
	 * @fn		void visit(Print *n)
	 * @param	n the Print to visit
	 * @brief	Print is devided into: Exp.
	 */
	virtual void visit(Print *n);

	/**
	 * @fn		void visit(Assign *n)
	 * @param	n the Assign to visit
	 * @brief	Assign is devided into: Identifier and Exp.
	 */
	virtual void visit(Assign *n);

	/**
	 * @fn		void visit(ArrayAssign *n)
	 * @param	n the ArrayAssign to visit
	 * @brief	ArrayAssign is devided into: Identifier and 2 Exp.
	 */
	virtual void visit(ArrayAssign *n);

	/**
	 * @fn		void visit(And *n)
	 * @param	n the And to visit
	 * @brief	And is devided into: 2 Exp.
	 */
	virtual void visit(And *n);

	/**
	 * @fn		void visit(LessThan *n)
	 * @param	n the LessThan to visit
	 * @brief	LessThan is devided into: 2 Exp.
	 */
	virtual void visit(LessThan *n);

	/**
	 * @fn		void visit(Plus *n)
	 * @param	n the Plus to visit
	 * @brief	Plus is devided into: 2 Exp.
	 */
	virtual void visit(Plus *n);

	/**
	 * @fn		void visit(Minus *n)
	 * @param	n the Minus to visit
	 * @brief	Minus is devided into: 2 Exp.
	 */
	virtual void visit(Minus *n);

	/**
	 * @fn		void visit(Times *n)
	 * @param	n the Times to visit
	 * @brief	Times is devided into: 2 Exp.
	 */
	virtual void visit(Times *n);

	/**
	 * @fn		void visit(ArrayLookup *n)
	 * @param	n the ArrayLookup to visit
	 * @brief	ArrayLookup is devided into: 2 Exp.
	 */
	virtual void visit(ArrayLookup *n);

	/**
	 * @fn		void visit(ArrayLength *n)
	 * @param	n the ArrayLength to visit
	 * @brief	ArrayLength is devided into: Exp.
	 */
	virtual void visit(ArrayLength *n);

	/**
	 * @fn		void visit(Call *n)
	 * @param	n the Call to visit
	 * @brief	Call is devided into: Exp, Identifier and ExpList.
	 */
	virtual void visit(Call *n);

	/**
	 * @fn		void visit(IntegerLiteral *n)
	 * @param	n the IntegerLiteral to visit
	 * @brief	IntegerLiteral is devided into: int.
	 */
	virtual void visit(IntegerLiteral *n);

	/**
	 * @fn		void visit(True *n)
	 * @param	n the True to visit
	 */	
	virtual void visit(True *n);

	/**
	 * @fn		void visit(False *n)
	 * @param	n the False to visit
	 */	
	virtual void visit(False *n);

	/**
	 * @fn		void visit(IdentifierExp *n)
	 * @param	n the IdentifierExp to visit
	 * @brief	IdentifierExp is devided into: std::string.
	 */
	virtual void visit(IdentifierExp *n);

	/**
	 * @fn		void visit(This *n)
	 * @param	n the This to visit
	 */	
	virtual void visit(This *n);

	/**
	 * @fn		void visit(NewArray *n)
	 * @param	n the NewArray to visit
	 * @brief	NewArray is devided into: Exp.
	 */
	virtual void visit(NewArray *n);

	/**
	 * @fn		void visit(NewObject *n)
	 * @param	n the NewObject to visit
	 * @brief	NewObject is devided into: Identifier.
	 */
	virtual void visit(NewObject *n);

	/**
	 * @fn		void visit(Not *n)
	 * @param	n the Not to visit
	 * @brief	Not is devided into: Exp.
	 */
	virtual void visit(Not *n);

	/**
	 * @fn		void visit(Identifier *n)
	 * @param	n the Identifier to visit
	 * @brief	Identifier is devided into: std::string.
	 */
	virtual void visit(Identifier *n);
};

/**
 * @class	TypeDepthFirstVisitor
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Class that visits and returns the type of the visited node.
 * @see		TypeVisitor
 */
class TypeDepthFirstVisitor : public TypeVisitor {
public:
	/**
	 * @fn		Type*  visit(Program *n)
	 * @param	n the Program to visit
	 * @return	NULL
	 * @brief	Program is devided into: a MainClass and ClassDeclList.
	 */
	Type*  visit(Program *n);

	/**
	 * @fn		Type*  visit(MainClass *n)
	 * @param	n the MainClass to visit
	 * @return	NULL
	 * @brief	MainClass is devided into: 2 Identifiers and a Statement.
	 */
	Type*  visit(MainClass *n);

	/**
	 * @fn		Type*  visit(ClassDeclSimple *n)
	 * @param	n the ClassDeclSimple to visit
	 * @return	NULL
	 * @brief	ClassDeclSimple is devided into: Identifier, VarDeclList and MethodDeclList.
	 */
	Type*  visit(ClassDeclSimple *n);

	/**
	 * @fn		Type*  visit(ClassDeclExtends *n)
	 * @param	n the ClassDeclExtends to visit
	 * @return	NULL
	 * @brief	Not implemented! ClassDeclExtends is devided into: 2 Identifiers, VarDeclList and MethodDeclList.
	 */
	Type*  visit(ClassDeclExtends *n);

	/**
	 * @fn		Type*  visit(VarDecl *n)
	 * @param	n the VarDecl to visit
	 * @return	NULL
	 * @brief	VarDecl is devided into: Type and Identifier.
	 */
	Type*  visit(VarDecl *n);

	/**
	 * @fn		Type*  visit(MethodDecl *n)
	 * @param	n the MethodDecl to visit
	 * @return	NULL
	 * @brief	MethodDecl is devided into: Type*, Identifier, FormalList, VarDeclList, StatementList and Exp.
	 */
	Type*  visit(MethodDecl *n);

	/**
	 * @fn		Type*  visit(Formal *n)
	 * @param	n the Formal to visit
	 * @return	NULL
	 * @brief	Formal is devided into: Type* and Identifier.
	 */
	Type*  visit(Formal *n);

	/**
	 * @fn		Type*  visit(IntArrayType *n)
	 * @param	n the IntArrayType to visit
	 * @return	NULL
	 */
	Type*  visit(IntArrayType *n);

	/**
	 * @fn		Type*  visit(BooleanType *n)
	 * @param	n the BooleanType to visit
	 * @return	NULL
	 */
	Type*  visit(BooleanType *n);

	/**
	 * @fn		Type*  visit(IntegerType *n)
	 * @param	n the IntegerType to visit
	 * @return	NULL
	 */
	Type*  visit(IntegerType *n);

	/**
	 * @fn		Type*  visit(IdentifierType *n)
	 * @param	n the IdentifierType to visit
	 * @return	NULL
	 * @brief	IdentifierType is devided into: string.
	 */
	Type*  visit(IdentifierType *n);

	/**
	 * @fn		Type*  visit(Block *n)
	 * @param	n the Block to visit
	 * @return	NULL
	 * @brief	Block is devided into: StatementList.
	 */
	Type*  visit(Block *n);

	/**
	 * @fn		Type*  visit(If *n)
	 * @param	n the If to visit
	 * @return	NULL
	 * @brief	If is devided into: Exp and Statement.
	 */
	Type*  visit(If *n);

	/**
	 * @fn		Type*  visit(While *n)
	 * @param	n the While to visit
	 * @return	NULL
	 * @brief	While is devided into: Exp and Statement.
	 */
	Type*  visit(While *n);

	/**
	 * @fn		Type*  visit(Print *n)
	 * @param	n the Print to visit
	 * @return	NULL
	 * @brief	Print is devided into: Exp.
	 */
	Type*  visit(Print *n);

	/**
	 * @fn		Type*  visit(Assign *n)
	 * @param	n the Assign to visit
	 * @return	NULL
	 * @brief	Assign is devided into: Identifier and Exp.
	 */
	Type*  visit(Assign *n);

	/**
	 * @fn		Type*  visit(ArrayAssign *n)
	 * @param	n the ArrayAssign to visit
	 * @return	NULL
	 * @brief	ArrayAssign is devided into: Identifier and 2 Exp.
	 */
	Type*  visit(ArrayAssign *n);

	/**
	 * @fn		Type*  visit(And *n)
	 * @param	n the And to visit
	 * @return	NULL
	 * @brief	And is devided into: 2 Exp.
	 */
	Type*  visit(And *n);

	/**
	 * @fn		Type*  visit(LessThan *n)
	 * @param	n the LessThan to visit
	 * @return	NULL
	 * @brief	LessThan is devided into: 2 Exp.
	 */
	Type*  visit(LessThan *n);

	/**
	 * @fn		Type*  visit(Plus *n)
	 * @param	n the Plus to visit
	 * @return	NULL
	 * @brief	Plus is devided into: 2 Exp.
	 */
	Type*  visit(Plus *n);

	/**
	 * @fn		Type*  visit(Minus *n)
	 * @param	n the Minus to visit
	 * @return	NULL
	 * @brief	Minus is devided into: 2 Exp.
	 */
	Type*  visit(Minus *n);

	/**
	 * @fn		Type*  visit(Times *n)
	 * @param	n the Times to visit
	 * @return	NULL
	 * @brief	Times is devided into: 2 Exp.
	 */
	Type*  visit(Times *n);

	/**
	 * @fn		Type*  visit(ArrayLookup *n)
	 * @param	n the ArrayLookup to visit
	 * @return	NULL
	 * @brief	ArrayLookup is devided into: 2 Exp.
	 */
	Type*  visit(ArrayLookup *n);

	/**
	 * @fn		Type*  visit(ArrayLength *n)
	 * @param	n the ArrayLength to visit
	 * @return	NULL
	 * @brief	ArrayLength is devided into: Exp.
	 */
	Type*  visit(ArrayLength *n);

	/**
	 * @fn		Type*  visit(Call *n)
	 * @param	n the Call to visit
	 * @return	NULL
	 * @brief	Call is devided into: Exp, Identifier and ExpList.
	 */
	Type*  visit(Call *n);

	/**
	 * @fn		Type*  visit(IntegerLiteral *n)
	 * @param	n the IntegerLiteral to visit
	 * @return	NULL
	 * @brief	IntegerLiteral is devided into: int.
	 */
	Type*  visit(IntegerLiteral *n);

	/**
	 * @fn		Type*  visit(True *n)
	 * @param	n the True to visit
	 * @return	NULL
	 */	
	Type*  visit(True *n);

	/**
	 * @fn		Type*  visit(False *n)
	 * @param	n the False to visit
	 * @return	NULL
	 */	
	Type*  visit(False *n);

	/**
	 * @fn		Type*  visit(IdentifierExp *n)
	 * @param	n the IdentifierExp to visit
	 * @return	NULL
	 * @brief	IdentifierExp is devided into: std::string.
	 */
	Type*  visit(IdentifierExp *n);

	/**
	 * @fn		Type*  visit(This *n)
	 * @param	n the This to visit
	 * @return	NULL
	 */	
	Type*  visit(This *n);

	/**
	 * @fn		Type*  visit(NewArray *n)
	 * @param	n the NewArray to visit
	 * @return	NULL
	 * @brief	NewArray is devided into: Exp.
	 */
	Type*  visit(NewArray *n);

	/**
	 * @fn		Type*  visit(NewObject *n)
	 * @param	n the NewObject to visit
	 * @return	NULL
	 * @brief	NewObject is devided into: Identifier.
	 */
	Type*  visit(NewObject *n);

	/**
	 * @fn		Type*  visit(Not *n)
	 * @param	n the Not to visit
	 * @return	NULL
	 * @brief	Not is devided into: Exp.
	 */
	Type*  visit(Not *n);

	/**
	 * @fn		Type*  visit(Identifier *n)
	 * @param	n the Identifier to visit
	 * @return	NULL
	 * @brief	Identifier is devided into: std::string.
	 */
	Type*  visit(Identifier *n);
};
#endif
