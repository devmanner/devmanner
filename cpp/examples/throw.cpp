#include <iostream>
#include <cstdlib>
#include <iomanip>
#include <vector>

using namespace std;

namespace bar {
    void baz(int i) {
         std::cout << __PRETTY_FUNCTION__ << endl;
    }
}

struct Foo {
       ~Foo() {
              std::cout << __PRETTY_FUNCTION__ << endl;
       }
};

void foo() {
     Foo f;
     throw("rocks");
     cout << "kalle" << endl;
}

class NoDefault {
NoDefault() { }
//NoDefault(const NoDefault&) { }
public:
   NoDefault(int) { }      
};

int main() {
    std::cout << std::setiosflags(std::ios_base::right) << std::setw(10) << "foo" << std::endl;
    
    std::cout << std::resetiosflags(std::ios_base::right) << std::resetiosflags(std::ios_base::left)
              << std::setiosflags(std::ios_base::internal) << "<" << setw(10) << "hej" << ">" << std::endl;
    bar::baz(10);
    
    std::vector<NoDefault> v;

    v.push_back(1);
    v.push_back(NoDefault(2));
    
    std::cout << v.size() << std::endl;
    
    try {
        foo();
    }
    catch (...) {
    }
    
    system("PAUSE");
    return 0;
}
