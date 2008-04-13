#include <iostream>
#include <string>


int main() {
  string s;
  cout << "Enter something, end qith Ctrl-d." << endl;
  while (cin >> s)
    cout << "[" << s << "]" << endl;

}
