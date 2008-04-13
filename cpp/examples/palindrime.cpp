#include <iostream>
#include <iterator>
#include <string>

bool is_palindrome(const std::string& s) {
	return std::equal(s.begin(), s.end(), s.rbegin());
}

int main() {
	std::string in;
	std::cin >> in;

	is_palindrome(in.c_str());
		
   

	return 0;
}
