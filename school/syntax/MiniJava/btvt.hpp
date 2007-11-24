#ifndef _BTVT_HPP_
#define _BTVT_HPP_

#include "visitor.hpp"
#include "symbol_table.hpp"

/**
 * @class	cBtvt
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	Build Type Visitor Table.
 *			Visitor that builds the symbol table, only implements
 *			visit on ClassDeclSimple, the rest is inherited by DepthFirstVisitor.
 * @see		DepthFirstVisitor
 */
class cBtvt : public DepthFirstVisitor {
private:
	cSymbolTable &m_table;
public:

	/**
	 * @fn		cBtvt(cSymbolTable &t)
	 * @param	t the table to set
	 * @brief	Constructor that sets the table.
	 */
	cBtvt(cSymbolTable &t) : m_table(t) { }

	/**
	 * @fn		cSymbolTable& get_table() const
	 * @return	the table
	 */
	cSymbolTable& get_table() const {
		return m_table;
	}

	/**
	 * @fn		void visit(ClassDeclSimple *n)
	 * @param	n the class declaration to start from
	 * @brief	does all that DepthFirstVisitor::visit does, and adds 
	 *			the param n to the table.
	 * @see		DepthFirstVisitor
	 */
	virtual void visit(ClassDeclSimple *n) {
		DepthFirstVisitor::visit(n);
		m_table.add(n);
	}
	  
	using DepthFirstVisitor::visit;
};


#endif

