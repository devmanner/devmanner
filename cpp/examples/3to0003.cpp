#include <iostream>
#include <string>
#include <sstream>

using namespace std;

string format_string(const long &counter) {
  if (!counter)
    return "0000";

  ostringstream format_str;
  for (long cnt = counter; cnt < 1000; cnt *= 10)
    format_str << '0';
 
  format_str << counter;
  return format_str.str();
}

int main() {
  for(long counter=0; counter < 1100; counter += 10)
    cout << format_string(counter) << endl;
  return 0;
}

