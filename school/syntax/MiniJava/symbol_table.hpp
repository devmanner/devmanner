#ifndef _SYMBOL_TABLE_HPP_
#define _SYMBOL_TABLE_HPP_

#include "types.hpp"
#include <set>
#include <vector>
#include <string>
#include <iostream>
#include <iterator>

/**
 * @class	cSymbolTable
 * @author	Tomas Mannerstedt
 * @author	Kristoffer Roupé
 * @brief	The symbol table as a singleton class.
 */
class cSymbolTable {
private:
  typedef std::string type_t, name_t;
public:
  typedef std::vector<type_t> type_vec;
private:
  /**
   * @struct	cVar
   * @brief	A variable.
   */
  struct cVar {
    name_t m_name;
    bool operator<(const cVar &v) const { return m_name < v.m_name; }
    type_t m_type;
  };
  typedef std::set<cVar> var_vec;
  
  /**
   * @struct	cMethod
   * @brief	A method.
   */
  struct cMethod {
    name_t m_name;
    bool operator<(const cMethod &m) const { return m_name < m.m_name; }
    type_vec m_params;
    var_vec m_locals;
    type_t m_return;
  };
  typedef std::set<cMethod> meth_vec;
  /**
   * @struct	cClass
   * @brief	A class.
   */
  struct cClass {
    name_t m_name;
    bool operator<(const cClass &c) const { return m_name < c.m_name; }
    var_vec m_memVars;
    meth_vec m_methods;
  };
  typedef std::set<cClass> class_vec;
  
  class_vec m_classes;
  
  /**
   * @fn		cSymbolTable()
   * @brief	Default constructor
   */
  cSymbolTable() : m_classes() { }
  
  /**
   * @fn		std::string str_get_var(const std::string &clss, const std::string &func, const std::string &var)
   * @param	clss the class that the variable is in
   * @param	func the function that the variable is in
   * @param	var	the variable to get the type on
   * @return	the type of the variable as a std::string
   * @throw	rocks
   */
  std::string str_get_var(const std::string &clss, const std::string &func, const std::string &var) {
    cClass c;
    c.m_name = clss;
    class_vec::const_iterator citr = m_classes.find(c);
    if (citr == m_classes.end()) {
      printf("No such class: %s\n", clss.c_str());
      throw("rocks");
    }
    
    cVar v;
    v.m_name = var;
    if (func != "none") {
      cMethod m;
      m.m_name = func;
      meth_vec::const_iterator mitr = citr->m_methods.find(m);
      var_vec::const_iterator vitr = mitr->m_locals.find(v);
      if (vitr != mitr->m_locals.end())
	return vitr->m_type;
    }
    
    var_vec::const_iterator vitr = citr->m_memVars.find(v);
    if (vitr == citr->m_memVars.end()) {
      printf("Undeclared identifier: %s\n", var.c_str());
      throw "rocks";
    }
    return vitr->m_type;
  }
  
  Type* alloc_type(const std::string &type) {
    if (type == "int")
      return new IntegerType();
    else if (type == "boolean")
      return new BooleanType();
    else if (type == "int[]")
      return new IntArrayType();
    return new IdentifierType(type);
  }
  
public:
  /**
   * @fn		cSymbolTable& get_instance()
   * @return	a static instance (allways the same) to the symboltable
   */
  static cSymbolTable& get_instance() {
    static cSymbolTable s;
    return s;
  }
  /**
   * @fn		Type* get_var(const std::string &clss, const std::string &func, const std::string &var)
   * @param	clss the class that the variable is in
   * @param	func the function that the variable is in
   * @param	var	the variable to get the type on
   * @return	the type of the variable as: IntegerType, BooleanType, IntArrayType or IdentifierType
   * @throw	rocks
   * @brief	Returns the variable as some kind of Type*
   * @see		str_get_var
   * @see		IntegerType
   * @see		BooleanType
   * @see		IntArrayType
   * @see		IdentifierType
   */
  inline Type* get_var(const std::string &clss, const std::string &func, const std::string &var) {
    return alloc_type(str_get_var(clss, func, var));
  }
  
  Type* get_func(const std::string &clss, const std::string &func, const type_vec &args) {
    cClass c;
    c.m_name = clss;
    class_vec::const_iterator citr = m_classes.find(c);
    if (citr == m_classes.end()) {
      printf("No such class: %s\n", clss.c_str());
      throw("rocks");
    }
    
    cMethod m;
    m.m_name = func;
    meth_vec::const_iterator mitr = citr->m_methods.find(m);
    if (mitr == citr->m_methods.end()) {
      printf("No such method: %s.%s\n", clss.c_str(), func.c_str());
      throw("rocks");
    }
    
    if (args != mitr->m_params) {
      printf("Argument list doesn't match for call to %s.%s\n", clss.c_str(), func.c_str());
      throw("rocks");
    }
    
    return alloc_type(mitr->m_return);
  }
  
  /**
   * @fn		void add(ClassDeclSimple *d)
   * @param	d the class declaration to add
   * @throw	rocks
   * @brief	Adds a class declaration to the table.
   */
  void add(ClassDeclSimple *d) {
    cClass c;
    c.m_name = d->i->s;

    /* Error check */
    if (m_classes.find(c) != m_classes.end()) {
      printf("Classname already used\n");
      throw "rocks";
    }

    for (VarDeclList::const_iterator itr = d->vl->begin(); itr != d->vl->end(); ++itr) {
      cVar tmp;
      tmp.m_name = (*itr)->i->s;
      tmp.m_type = (*itr)->t->to_string();
      if (!c.m_memVars.insert(tmp).second) {
	printf("%s was already declared in this scope.\n", tmp.m_name.c_str());
	throw("rocks");
      }
    }

    for (MethodDeclList::const_iterator itr = d->ml->begin(); itr != d->ml->end(); ++itr) {
      cMethod m;
      /* Get the name. */
      m.m_name = (*itr)->i->s;
      /* Get the return type of a string. */
      m.m_return = (*itr)->t->to_string();
      
      /* Get the argument list. */
      for (FormalList::const_iterator aitr = (*itr)->fl->begin(); aitr != (*itr)->fl->end(); ++aitr) {
	cVar tmp;
	tmp.m_type = (*aitr)->t->to_string();
	tmp.m_name = (*aitr)->i->s;
	if (!m.m_locals.insert(tmp).second) {
	  printf("%s was already declared as an argument. Use unique names on arguments.\n", tmp.m_name.c_str());
	  throw("rocks");
	}	
	m.m_params.push_back((*aitr)->t->to_string());
      }

      /* Get the local variables list. */
      for (VarDeclList::const_iterator vitr = (*itr)->vl->begin(); vitr != (*itr)->vl->end(); ++vitr) {
	cVar tmp;
	tmp.m_name = (*vitr)->i->s;
	tmp.m_type = (*vitr)->t->to_string();
	if (!m.m_locals.insert(tmp).second) {
	  printf("%s was already declared in this scope.\n", tmp.m_name.c_str());
	  throw("rocks");
	}
      }
      if (c.m_methods.find(m) != c.m_methods.end()) {
	printf("No overloaded methods in minijava.");
	throw("rocks");
      }
      else 
	c.m_methods.insert(m);
    }
    m_classes.insert(c);
  }

  /**
   * @fn		void print() const
   * @brief	prints the table.
   */
  void print() const {
    printf("Classes:\n");
    for (class_vec::const_iterator itr = m_classes.begin(); itr != m_classes.end(); ++itr) {
      printf("\t%s\n", itr->m_name.c_str());
      printf("\t\tMemvars:\n");
      for (var_vec::const_iterator mvitr = itr->m_memVars.begin(); mvitr != itr->m_memVars.end(); ++mvitr)
	printf("\t\t\t%s %s\n", mvitr->m_type.c_str(), mvitr->m_name.c_str());
      
      printf("\t\tMethods:\n");
      for (meth_vec::const_iterator meitr = itr->m_methods.begin(); meitr != itr->m_methods.end(); ++meitr) {
	printf("\t\t\t%s %s(", meitr->m_return.c_str(), meitr->m_name.c_str());
	for (type_vec::const_iterator paritr = meitr->m_params.begin(); paritr != meitr->m_params.end(); ++paritr)
	  printf("%s, ", paritr->c_str());
	printf(")\n");
	
	printf("\t\t\tLocals:\n");
	for (var_vec::const_iterator varitr = meitr->m_locals.begin(); varitr != meitr->m_locals.end(); ++varitr)
	  printf("\t\t\t\t%s %s\n", varitr->m_type.c_str(), varitr->m_name.c_str());	
      }
    }
  }
};

#endif
