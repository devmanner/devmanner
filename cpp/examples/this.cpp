#include <cstdio>

struct Foo {
    Foo() {
	printf("Foo::this %x\n", this);
    }
};

struct Bar : public Foo {
    Bar() : Foo() {
	printf("Bar::this %x\n", this);
    }	
};

int main() {
    Bar b;
    return 0;
}
