#include "visitor.hpp"
#include <iostream>
#include <cassert>

/* ==========================[ DepthFirstVisitor  ]============================== */
void DepthFirstVisitor::visit(Program *n) {
	n->m->accept(this);
	for (size_t i = 0; i < n->cl->size(); i++ ) {
		n->cl->elementAt(i)->accept(this);
	}
}

void DepthFirstVisitor::visit(MainClass *n) {
	n->i1->accept(this);
	n->i2->accept(this);
	n->s->accept(this);
}

void DepthFirstVisitor::visit(ClassDeclSimple *n) {
	n->i->accept(this);
	for (size_t i = 0; i < n->vl->size(); i++ ) {
		n->vl->elementAt(i)->accept(this);
	}
	for (size_t i = 0; i < n->ml->size(); i++ ) {
		n->ml->elementAt(i)->accept(this);
	}
}

void DepthFirstVisitor::visit(ClassDeclExtends *n) {
	n->i->accept(this);
	n->j->accept(this);
	for (size_t i = 0; i < n->vl->size(); i++ ) {
		n->vl->elementAt(i)->accept(this);
	}
	for (size_t i = 0; i < n->ml->size(); i++ ) {
		n->ml->elementAt(i)->accept(this);
	}
}

void DepthFirstVisitor::visit(VarDecl *n) {
	n->t->accept(this);
	n->i->accept(this);
}

void DepthFirstVisitor::visit(MethodDecl *n) {
	n->t->accept(this);
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
	n->e->accept(this);
}

void DepthFirstVisitor::visit(Formal *n) {
	n->t->accept(this);
	n->i->accept(this);
}

void DepthFirstVisitor::visit(IntArrayType *n) {
}

void DepthFirstVisitor::visit(BooleanType *n) {
}

void DepthFirstVisitor::visit(IntegerType *n) {
}

void DepthFirstVisitor::visit(IdentifierType *n) {
}

void DepthFirstVisitor::visit(Block *n) {
	for ( size_t i = 0; i < n->sl->size(); i++ ) {
		n->sl->elementAt(i)->accept(this);
	}
}

void DepthFirstVisitor::visit(If *n) {
	n->e->accept(this);
	n->s1->accept(this);
	n->s2->accept(this);
}

void DepthFirstVisitor::visit(While *n) {
	n->e->accept(this);
	n->s->accept(this);
}

void DepthFirstVisitor::visit(Print *n) {
	n->e->accept(this);
}
	
void DepthFirstVisitor::visit(Assign *n) {
	n->i->accept(this);
	n->e->accept(this);
}

void DepthFirstVisitor::visit(ArrayAssign *n) {
	n->i->accept(this);
	n->e1->accept(this);
	n->e2->accept(this);
}

void DepthFirstVisitor::visit(And *n) {
	n->e1->accept(this);
	n->e2->accept(this);
}

void DepthFirstVisitor::visit(LessThan *n) {
	n->e1->accept(this);
	n->e2->accept(this);
}

void DepthFirstVisitor::visit(Plus *n) {
	n->e1->accept(this);
	n->e2->accept(this);
}

void DepthFirstVisitor::visit(Minus *n) {
	n->e1->accept(this);
	n->e2->accept(this);
}

void DepthFirstVisitor::visit(Times *n) {
	n->e1->accept(this);
	n->e2->accept(this);
}

void DepthFirstVisitor::visit(ArrayLookup *n) {
	n->e1->accept(this);
	n->e2->accept(this);
}

void DepthFirstVisitor::visit(ArrayLength *n) {
	n->e->accept(this);
}

void DepthFirstVisitor::visit(Call *n) {
	n->e->accept(this);
	n->i->accept(this);
	for ( size_t i = 0; i < n->el->size(); i++ ) {
		n->el->elementAt(i)->accept(this);
	}
}

void DepthFirstVisitor::visit(IntegerLiteral *n) {
}

void DepthFirstVisitor::visit(True *n) {
}

void DepthFirstVisitor::visit(False *n) {
}

void DepthFirstVisitor::visit(IdentifierExp *n) {
}

void DepthFirstVisitor::visit(This *n) {
}

void DepthFirstVisitor::visit(NewArray *n) {
	n->e->accept(this);
}

void DepthFirstVisitor::visit(NewObject *n) {
}

void DepthFirstVisitor::visit(Not *n) {
	n->e->accept(this);
}

void DepthFirstVisitor::visit(Identifier *n) {
}


/*  ===================================[ PrettyPrintVisitor ]===================================  */
void PrettyPrintVisitor::visit(Program *n) {
	n->m->accept(this);
	for ( size_t i = 0; i < n->cl->size(); i++ ) {
	  std::endl(std::cout);
		n->cl->elementAt(i)->accept(this);
	}
}
	
void PrettyPrintVisitor::visit(MainClass *n) {
	std::cout << "class ";
	n->i1->accept(this);
	std::endl(std::cout << " {");
	std::cout <<"  static void main (String [] ";
	n->i2->accept(this);
	std::endl(std::cout <<") {");
	std::cout <<"    ";
	n->s->accept(this);
	std::endl(std::cout << "  }");
	std::endl(std::cout << "}");
}

void PrettyPrintVisitor::visit(ClassDeclSimple *n) {
	std::cout <<("class ");
	n->i->accept(this);
	std::endl(std::cout << " { ");
	for ( size_t i = 0; i < n->vl->size(); i++ ) {
		std::cout <<("  ");
		n->vl->elementAt(i)->accept(this);
		if ( i+1 < n->vl->size())
		    std::endl(std::cout);
	}
	for ( size_t i = 0; i < n->ml->size(); i++ ) {
		std::endl(std::cout);
		n->ml->elementAt(i)->accept(this);
	}
	std::endl(std::cout);
	std::endl(std::cout << "}");
}
	
void PrettyPrintVisitor::visit(ClassDeclExtends *n) {
	std::cout << "class ";
	n->i->accept(this);
	std::endl(std::cout << " extends ");
	n->j->accept(this);
	std::endl(std::cout << " { ");
	for ( size_t i = 0; i < n->vl->size(); i++ ) {
		std::cout << "  ";
		n->vl->elementAt(i)->accept(this);
		if ( i+1 < n->vl->size() )
		    std::endl(std::cout);
	}
	for ( size_t i = 0; i < n->ml->size(); i++ ) {
		std::endl(std::cout);
		n->ml->elementAt(i)->accept(this);
	}
	std::endl(std::cout);
	std::endl(std::cout << "}");
}

void PrettyPrintVisitor::visit(VarDecl *n) {
	n->t->accept(this);
	std::cout <<(" ");
	n->i->accept(this);
	std::cout <<(";");
}

void PrettyPrintVisitor::visit(MethodDecl *n) {
	std::cout <<("  ");
	n->t->accept(this);
	std::cout <<(" ");
	n->i->accept(this);
	std::cout <<(" (");
	for ( size_t i = 0; i < n->fl->size(); i++ ) {
		n->fl->elementAt(i)->accept(this);
		if (i+1 < n->fl->size()) { std::cout <<(", "); }
	}
	std::endl(std::cout << ") { ");
	for ( size_t i = 0; i < n->vl->size(); i++ ) {
		std::cout << "    ";
		n->vl->elementAt(i)->accept(this);
		std::endl(std::cout);
	}
	for ( size_t i = 0; i < n->sl->size(); i++ ) {
		std::cout << "    ";
		n->sl->elementAt(i)->accept(this);
		if ( i < n->sl->size() )
		    std::endl(std::cout << "");
	}
	std::cout << "    return ";
	n->e->accept(this);
	std::endl(std::cout << ";");
	std::cout << "  }";
}

void PrettyPrintVisitor::visit(Formal *n) {
	n->t->accept(this);
	std::cout <<(" ");
	n->i->accept(this);
}

void PrettyPrintVisitor::visit(IntArrayType *n) {
	std::cout <<("int []");
}

void PrettyPrintVisitor::visit(BooleanType *n) {
	std::cout <<("boolean");
}

void PrettyPrintVisitor::visit(IntegerType *n) {
	std::cout <<("int");
}

void PrettyPrintVisitor::visit(IdentifierType *n) {
	std::cout << n->s;
}

void PrettyPrintVisitor::visit(Block *n) {
	std::endl(std::cout << "{ ");
	for ( size_t i = 0; i < n->sl->size(); i++ ) {
		std::cout <<("      ");
		n->sl->elementAt(i)->accept(this);
		std::endl(std::cout);
	}
	std::cout <<("    } ");
}

void PrettyPrintVisitor::visit(If *n) {
	std::cout <<("if (");
	n->e->accept(this);
	std::endl(std::cout << ") ");
	std::cout << "    ";
	n->s1->accept(this);
	std::endl(std::cout);
	std::cout << "    else ";
	n->s2->accept(this);
}

void PrettyPrintVisitor::visit(While *n) {
	std::cout << "while (";
	n->e->accept(this);
	std::cout << ") ";
	n->s->accept(this);
}

void PrettyPrintVisitor::visit(Print *n) {
	std::cout << "System.out.println(";
	n->e->accept(this);
	std::cout << ");";
}
	
void PrettyPrintVisitor::visit(Assign *n) {
	n->i->accept(this);
	std::cout << " = ";
	n->e->accept(this);
	std::cout << ";";
}

void PrettyPrintVisitor::visit(ArrayAssign *n) {
	n->i->accept(this);
	std::cout << "[";
	n->e1->accept(this);
	std::cout << "] = ";
	n->e2->accept(this);
	std::cout << ";";
}

void PrettyPrintVisitor::visit(And *n) {
	std::cout << "(";
	n->e1->accept(this);
	std::cout << " && ";
	n->e2->accept(this);
	std::cout << ")";
}

void PrettyPrintVisitor::visit(LessThan *n) {
	std::cout << "(";
	n->e1->accept(this);
	std::cout << " < ";
	n->e2->accept(this);
	std::cout << ")";
}

void PrettyPrintVisitor::visit(Plus *n) {
	std::cout << "(";
	n->e1->accept(this);
	std::cout << " + ";
	n->e2->accept(this);
	std::cout << ")";
}

void PrettyPrintVisitor::visit(Minus *n) {
	std::cout <<("(");
	n->e1->accept(this);
	std::cout <<(" - ");
	n->e2->accept(this);
	std::cout <<(")");
}

void PrettyPrintVisitor::visit(Times *n) {
	std::cout <<("(");
	n->e1->accept(this);
	std::cout <<(" * ");
	n->e2->accept(this);
	std::cout <<(")");
}

void PrettyPrintVisitor::visit(ArrayLookup *n) {
	n->e1->accept(this);
	std::cout <<("[");
	n->e2->accept(this);
	std::cout <<("]");
}

void PrettyPrintVisitor::visit(ArrayLength *n) {
	n->e->accept(this);
	std::cout <<(".length");
}

void PrettyPrintVisitor::visit(Call *n) {
	n->e->accept(this);
	std::cout <<("->");
	n->i->accept(this);
	std::cout <<("(");
	for ( size_t i = 0; i < n->el->size(); i++ ) {
		n->el->elementAt(i)->accept(this);
		if ( i+1 < n->el->size() ) { std::cout <<(", "); }
	}
	std::cout <<(")");
}

void PrettyPrintVisitor::visit(IntegerLiteral *n) {
	std::cout <<(n->i);
}

void PrettyPrintVisitor::visit(True *n) {
	std::cout <<("true");
}

void PrettyPrintVisitor::visit(False *n) {
	std::cout <<("false");
}

void PrettyPrintVisitor::visit(IdentifierExp *n) {
	std::cout <<(n->s);
}

void PrettyPrintVisitor::visit(This *n) {
	std::cout <<("this");
}

void PrettyPrintVisitor::visit(NewArray *n) {
	std::cout <<("new int [");
	n->e->accept(this);
	std::cout <<("]");
}

void PrettyPrintVisitor::visit(NewObject *n) {
	std::cout <<("new ");
	std::cout <<(n->i->s);
	std::cout <<("()");
}

void PrettyPrintVisitor::visit(Not *n) {
	std::cout <<("!");
	n->e->accept(this);
}

void PrettyPrintVisitor::visit(Identifier *n) {
	std::cout <<(n->s);
}

/*  ===================================[ TypeDepthFirstVisitor ]===================================  */
Type* TypeDepthFirstVisitor::visit(Program *n) {
	n->m->accept(this);
	for ( size_t i = 0; i < n->cl->size(); i++ ) {
		n->cl->elementAt(i)->accept(this);
	}
	return NULL;
}
	
Type* TypeDepthFirstVisitor::visit(MainClass *n) {
	n->i1->accept(this);
	n->i2->accept(this);
	n->s->accept(this);
	return NULL;
}
	
Type* TypeDepthFirstVisitor::visit(ClassDeclSimple *n) {
	n->i->accept(this);
	for ( size_t i = 0; i < n->vl->size(); i++ ) {
		n->vl->elementAt(i)->accept(this);
	}
	for ( size_t i = 0; i < n->ml->size(); i++ ) {
		n->ml->elementAt(i)->accept(this);
	}
	return NULL;
}
	
Type* TypeDepthFirstVisitor::visit(ClassDeclExtends *n) {
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

Type* TypeDepthFirstVisitor::visit(VarDecl *n) {
	n->t->accept(this);
	n->i->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(MethodDecl *n) {
	n->t->accept(this);
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
	n->e->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(Formal *n) {
	n->t->accept(this);
	n->i->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(IntArrayType *n) {
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(BooleanType *n) {
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(IntegerType *n) {
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(IdentifierType *n) {
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(Block *n) {
	for ( size_t i = 0; i < n->sl->size(); i++ ) {
		n->sl->elementAt(i)->accept(this);
	}
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(If *n) {
	n->e->accept(this);
	n->s1->accept(this);
	n->s2->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(While *n) {
	n->e->accept(this);
	n->s->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(Print *n) {
	n->e->accept(this);
	return NULL;
}
	
Type* TypeDepthFirstVisitor::visit(Assign *n) {
	n->i->accept(this);
	n->e->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(ArrayAssign *n) {
	n->i->accept(this);
	n->e1->accept(this);
	n->e2->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(And *n) {
	n->e1->accept(this);
	n->e2->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(LessThan *n) {
	n->e1->accept(this);
	n->e2->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(Plus *n) {
	n->e1->accept(this);
	n->e2->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(Minus *n) {
	n->e1->accept(this);
	n->e2->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(Times *n) {
	n->e1->accept(this);
	n->e2->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(ArrayLookup *n) {
	n->e1->accept(this);
	n->e2->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(ArrayLength *n) {
	n->e->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(Call *n) {
	n->e->accept(this);
	n->i->accept(this);
	for ( size_t i = 0; i < n->el->size(); i++ ) {
		n->el->elementAt(i)->accept(this);
	}
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(IntegerLiteral *n) {
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(True *n) {
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(False *n) {
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(IdentifierExp *n) {
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(This *n) {
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(NewArray *n) {
	n->e->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(NewObject *n) {
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(Not *n) {
	n->e->accept(this);
	return NULL;
}

Type* TypeDepthFirstVisitor::visit(Identifier *n) {
	return NULL;
}
