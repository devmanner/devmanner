#include <iostream>
#include <string>
#include "hasher.h"

using namespace std;

int main(){
	Hasher hasher;
	string str1 = "Hello";
	string str2 = "Hello"; 
	
	cout << str1 << ": " << hasher(str1, str1.length()) << endl;
	cout << str2 << ": " << hasher(str2, str2.length()) << endl;
	unsigned int a = hasher(str1, str1.length(),7), b = hasher(str2, str2.length(),7);
	cout << a << " - " << b << ": " <<  a - b << endl;

	char *charstr1 = "Hello";
	char *charstr2 = "Hello";

	cout << "[char]Hello: " << hasher(charstr1, strlen(charstr1)) << endl;
	cout << "[char]Tester: " << hasher(charstr2, strlen(charstr2)) << endl;
	cout << ": " << hasher(charstr1, strlen(charstr1)) - hasher(charstr2, strlen(charstr1)) << endl;

	cin.get();
	return 0;
}
