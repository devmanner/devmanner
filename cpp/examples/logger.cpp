#include <iostream>

class Logger {
  private:
  const char *m_fname;
  const char *m_func;
  int m_line;

  Logger() : m_fname(NULL), m_func(NULL), m_line(-1) {}

  /* Set logging properties. */
  inline void setprop(const char *fname, const char *func, const int line) {
    m_fname = fname;
    m_func = func;
    m_line = line;
  }
  
public:
  /* Wrapper macro. Cannot be a function since __FILE__ ... would be wrong. */
#define get_instance() _get_instance(__FILE__, __func__, __LINE__)
  
  static Logger& _get_instance(const char *fname, const char *func, const int line) {
    static Logger l;
    l.setprop(fname, func, line);
    return l;
  }

  void log(const char *mess) {
    /* Implement this the way you want it. */
    std::cerr << m_fname << " (" << m_line << ") " << m_func << "() [" << mess << "]" << std::endl;
  }
};


void foo() {
  Logger::get_instance().log("Logging in foo().");
}

int main() {
  Logger::get_instance().log("Logging in main().");
  foo();
  return 0;
}
