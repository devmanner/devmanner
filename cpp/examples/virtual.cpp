#include <cstdio>

class IC {
protected:
	virtual void MinMetod()=0;
};

class A : public IC {
public:
	void MinMetod() {
		printf("A::MinMetod()\n");
	}
};

class B : public A {
public:
	void MinMetod() {
		printf("B::MinMetod()\n");
	}
};

int main() {
	A a;
	B b;

	a.MinMetod();
	b.MinMetod();

	return 0;
}

