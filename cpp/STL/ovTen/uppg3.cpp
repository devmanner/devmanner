#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Person {
private:
  string fn;
  string ln;
public:
  Person() { }
  Person(const string &f, const string &n) : fn(f), ln(n) { }
  string firstname() const { return fn; }
  string lastname() const { return ln; }
};

ostream& operator<<(ostream &os, const Person &p) {
  os << "[" << p.firstname() << " " << p.lastname() << "]";
  return os;
}

struct Less : public binary_function<Person, Person, bool> {
  bool operator()(const Person &p1, const Person &p2) {
    return (p1.lastname() < p2.lastname())
      || (p1.lastname() == p2.lastname()
	  && p1.firstname() < p2.firstname());
  }
};


int main() {
  vector<Person> pv;
  pv.push_back(Person("Marc", "Kolding"));
  pv.push_back(Person("Bernt", "Roupe"));
  pv.push_back(Person("Marc-us", "Almgren"));
  pv.push_back(Person("Tomas ""Silverminken"" ", "Mannerstedt"));

  for_each(pv.begin(),pv.end(),Less());

}

