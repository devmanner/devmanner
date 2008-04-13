#include <stdarg.h>

template <class T>
class vec_t {
private:
  T m_array[20];

public:
  vec_t(T num, ...){ 
    va_list marker; 
    va_start(marker, num); 
    m_array[0] = num; 
    for(int i=1;i < 3; i++){ 
      T value = va_arg( marker, T);           
      m_array[i] = value; 
    } 
    va_end(marker); 
  }
};


int main () {
  vec_t<double> v(1.2, 1.2, 1.1);

  return 0;
}
