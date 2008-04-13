#include <iostream>
#include <cassert>

struct Base {
    virtual bool equals(Base *b)=0;
};

struct D1 : public Base {
    bool equals(Base *b) {
	if (dynamic_cast<D1*>(b))
	    return true;
	return false;
    }
};

struct D2 : public Base {
    bool equals(Base *b) {
	if (dynamic_cast<typeof(this)>(b))
	    return true;
	return false;
    }
};

template <typename T>
struct instance_of {
    template <typename P>
    bool operator()(P* p) {
	if (dynamic_cast<T*>(p))
	    return true;
	return false;	
    }
};

int main() {
    Base *b1 = new D1();
    Base *b2 = new D2();
    Base *b3 = new D2();

    if (b1->equals(b2))
	std::endl(std::cout << "b1 and b2 equal");
    else
	std::endl(std::cout << "b1 and b2 not equal");

    if (b2->equals(b3))
	std::endl(std::cout << "b2 and b3 equal");
    else
	std::endl(std::cout << "b2 and b3 not equal");
    
    instance_of<D1> i;
    if (i(b1))
	std::endl(std::cout << "b1 is instance of D1");
    if (i(b2))
	std::endl(std::cout << "b2 is instance of D1");

    return 0;
}
