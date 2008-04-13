#include <iostream>
#include <string>
#include <set>
#include <iterator>
#include <algorithm>

using namespace std;

class Person {
private:
  double salary;
  string fn;
  string ln;
public:
  Person(string f, string l, double s) : fn(f), ln(l), salary(s) {}
  ~Person() {}
  void ss(double s) { salary = s; }
  string fname() { return fn; }
  string lname() { return ln; }
};

struct fns {
  bool operator()(Person &p1, Person &p2) {
    return p1.fname() < p2.fname();
  }
};

struct lns {
  bool operator()(Person &p1, Person &p2) {
    return p1.fname() < p2.fname();
  }
};


int main() {
  {
    set<Person, fns> ps;
    ps.insert(Person("tomas", "mannerstedt", 41325233.9));
    ps.insert(Person("marc", "colding", 233.9));
    ps.insert(Person("bernt", "roupe", 35233.3));
    ps.insert(Person("marcus", "16+", 3.2));
    ps.insert(Person("tobbe", "gyllebring", 2141325235233.9));
    copy(ps.begin(), ps.end(), ostream_iterator(cout, "\n"));
  } {
    set<Person, lns> ps;
    ps.insert(Person("tomas", "mannerstedt", 41325233.9));
    ps.insert(Person("marc", "colding", 233.9));
    ps.insert(Person("bernt", "roupe", 35233.3));
    ps.insert(Person("marcus", "16+", 3.2));
    ps.insert(Person("tobbe", "gyllebring", 2141325235233.9));
    copy(ps.begin(), ps.end(), ostream_iterator(cout, "\n"));
  }
}
