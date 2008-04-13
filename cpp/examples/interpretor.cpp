#include <cstdio>

int n = 0;

struct Foo {
    int m1, m2;
    Foo(int x, int y) : m1(x), m2(y) { }
};

class aExp {
public:
    aExp() { }
    virtual ~aExp() { }
    virtual bool eval(Foo &f)=0;
};

class aBinaryOperator : public aExp {
protected:
    aExp *m_pexp1, *m_pexp2;
public:
    aBinaryOperator(aExp *p1, aExp *p2) : m_pexp1(p1), m_pexp2(p2) { }
    virtual ~aBinaryOperator() { delete m_pexp1; delete m_pexp2; }
    virtual bool eval(Foo &f)=0;
};

class cAnd : public aBinaryOperator {
public:
    cAnd(aExp *p1, aExp *p2) : aBinaryOperator(p1, p2) { }
    bool eval(Foo &f) {
	return m_pexp1->eval(f) && m_pexp2->eval(f);
    }
};

class cOr : public aBinaryOperator {
public:
    cOr(aExp *p1, aExp *p2) : aBinaryOperator(p1, p2) { }
    bool eval(Foo &f) {
	return m_pexp1->eval(f) || m_pexp2->eval(f);
    }
};

class cNot : public aExp {
private:
    aExp *m_pexp;
public:
    cNot(aExp *p) : m_pexp(p) { }
    ~cNot() { delete m_pexp; }
    bool eval(Foo &f) {
	return !m_pexp->eval(f);
    }
};

class cInt : public aExp {
private:
    int m_value;
public:
    cInt(int x) : m_value(x) { }
    bool eval(Foo &f) {
	return f.m1 == m_value || f.m2 == m_value;
    }
};

int main() {
    Foo a(1, 3);
    /*
    aExp *p = new cAnd(new cNot(new cAnd(new cInt(1), new cInt(2))), 
		       new cOr(new cAnd(new cInt(1), new cInt(2)),
			       new cAnd(new cInt(2), new cInt(3))));
    */
    aExp *p = new cInt(3);

    if (p->eval(a))
	printf("Match!\n");
    else
	printf("No match!\n");
    
    delete p;

    return 0;
}
