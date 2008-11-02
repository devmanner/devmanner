#include <iostream>
#include <set>
#include <string>

using namespace std;

string small_to_string(int x) {
  static string s []= {"", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
                       "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"};
  return s[x];
}

string mid_to_string(int x) {
  static string s[]= {"", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"};
  string res;
  if (x >= 20) {
    res += s[x/10];
    res += small_to_string(x % 10);
  }
  else
    res += small_to_string(x);
  
  return res;
}

string to_string(int x) {
  if (x == 1000)
    return "onethousand";
  string res ="";
  if (x >= 100) {
    res += small_to_string((x / 100) % 10);
    res += "hundred";
    if (x % 100)
      res += "and";
  }
  res += mid_to_string(x % 100);
  return res;
}

int count_chars(const string &s) {
  int res = 0;
  for (unsigned int i = 0; i < s.length(); ++i)
    if (s[i] != ' ')
      ++res;
  return res;
}

int main() {
  int n = 0;
  for (int i = 1; i <= 1000; ++i) {
    //n += count_chars(to_string(i));
    string s = to_string(i);
    int chars = count_chars(s);
    n += chars;
    cout << i << " " << s << " " << chars << endl;
  }
  cout << "Total: " << n << endl;

  system("PAUSE");
  return 0;
}
