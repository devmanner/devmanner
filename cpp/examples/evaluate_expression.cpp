#include <vector>
#include <map>
#include <iostream>
#include <iterator>
#include <string>
#include <algorithm>

#include <cstdio>

using namespace std;
typedef double(*op_func)(double, double);

typedef map<string, op_func, less<string> > operator_map;

double add(double x, double y) { return x+y; }
double subtract(double x, double y) { return x-y; }
double multiply(double x, double y) { return x*y; }
double divide(double x, double y) { return x/y; }

bool imp_higherPrio(string *operators) {
  static vector<string> v;
  // If first call setup the prio vector.
  if (v.empty()) {
    v.push_back("+");v.push_back("-");
    v.push_back("*");v.push_back("/");
  }
  cout << "before" << endl;
  if(operators[0] == 
     *find_first_of(v.begin(), v.end(), operators, &operators[2])){
    cout << "after" << endl;
    return true;
  }
  cout << "after" << endl;
  return false;
}

bool higherPrio(const string &o1, const string &o2) {
  static vector<string> v;
  // If first call setup the prio vector.
  if (v.empty()) {
    v.push_back("+");v.push_back("-");
    v.push_back("*");v.push_back("/");
  }
  return (find(find(v.begin(), v.end(), o2), v.end(), o1) != v.end());
}


int main(int argc, char *argv[]) {
  vector<string> postfix;
  vector<string> s;
  vector<string> tokens;
  tokens.push_back("1");
  tokens.push_back("+");
  tokens.push_back("2");
  tokens.push_back("*");
  tokens.push_back("3");
  tokens.push_back("-");
  tokens.push_back("4");
  
  operator_map operators;
  operators.insert(operator_map::value_type(string("+"), add));
  operators.insert(operator_map::value_type(string("-"), subtract));
  operators.insert(operator_map::value_type(string("*"), multiply));
  operators.insert(operator_map::value_type(string("/"), divide));
  
  for (vector<string>::iterator itr = tokens.begin(); itr != tokens.end(); ++itr) {
    // argv[i] is an operand.
    if (operators.find(operator_map::key_type(*itr)) == operators.end()) {
      postfix.push_back(*itr);
      cout << "Adding: " << *itr << " to postfix" << endl;
    }
    // argv[i] is an operator and stack is empty.
    else if (operators.find(*itr) != operators.end() && s.empty()) {
      s.push_back(*itr);
      cout << "Pushing: " << *itr << " to stack." << endl;
    }
    // argv[i] is an operator and stack is not empty.
    else if(operators.find(*itr) != operators.end() && !s.empty()) {
      // if topstak has higher prioroty than argc[i] add topstack to
      // postfix. Do this as long as topstack has higher prioroty than
      // argc[i].
      while (higherPrio(s.back(), *itr) && !s.empty()) {
	cout << "Moving: " << s.back() << " from stack to postfix" << endl;
	postfix.push_back(s.back());
	s.pop_back();
      }
      cout << "Pushing: " << *itr << " to stack" << endl;
      s.push_back(*itr);
    }  
  }
  // Pop all the remaining characters from the stack to the postfix string.
  while(!s.empty()) {
    cout << "Moving: " << s.back() << " from stack to postfix... at last..." << endl;
    postfix.push_back(s.back());
    s.pop_back();
  }

  copy(postfix.begin(), postfix.end(), ostream_iterator<string>(cout, " "));
  cout << endl;
  return 0;
}
