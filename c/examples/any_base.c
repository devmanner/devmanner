#include <stdio.h>

void print(int x, int base) {
	static const char num[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	if (x >= base)
		print(x/base, base);
	printf("%c", num[x % base]);
}

int main() {
	print(10, 2);
	puts("");
	print(12345678, 10);
	puts("");
	print(100, 2);
	puts("");
	print(255, 20);
	puts("");

	return 0;
}
