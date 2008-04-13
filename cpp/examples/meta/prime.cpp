#include <cstdio>

template<int X, int N>
class isNotPrime {
public:
	enum { result = (X % N) == 0 || isNotPrime<X, N-2>::result };
};

template<int X>
class isNotPrime<X, 1> {
public:
	enum { result = 0 };
};

template<int X>
class isPrime {
public:
	enum { result = !(isNotPrime<X, ((X/4)*2)+1>::result) };
};

template<>
class isPrime<1> {
public:
	enum { result = 0 };
};

template<>
class isPrime<2> {
public:
	enum { result = 0 };
};

int main() {
	const int prime1 = 2;
	printf("is %d a prime? %d\n", prime1, isPrime<prime1>::result);
	const int prime2 = 3;
	printf("is %d a prime? %d\n", prime2, isPrime<prime2>::result);
	const int prime3 = 6;
	printf("is %d a prime? %d\n", prime3, isPrime<prime3>::result);
	const int prime4 = 11;
	printf("is %d a prime? %d\n", prime4, isPrime<prime4>::result);
	const int prime5 = 15;
	printf("is %d a prime? %d\n", prime5, isPrime<prime5>::result);
	const int prime6 = 19;
	printf("is %d a prime? %d\n", prime6, isPrime<prime6>::result);
	const int prime7 = 463;
	printf("is %d a prime? %d\n", prime7, isPrime<prime7>::result);
	const int prime8 = 997;
	printf("is %d a prime? %d\n", prime8, isPrime<prime8>::result);
	const int prime9 = 999;
	printf("is %d a prime? %d\n", prime9, isPrime<prime9>::result);

	return 0;
}
