#include <cstdio>

template<int N>
class Fib {
public:
	enum { result = Fib<N-1>::result + Fib<N-2>::result };
};

template<>
class Fib<1> {
public:
	enum { result = 1 };
};

template<>
class Fib<0> {
public:
	enum { result = 1 };
};

int main() {
	printf("%d\n%d\n%d\n", Fib<3>::result, Fib<10>::result, Fib<20>::result);
	return 0;
}
