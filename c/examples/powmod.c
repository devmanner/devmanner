#include <stdio.h>
#include <math.h>


unsigned long int twopowmod(int power, unsigned int modulo) {
  int i;
  unsigned short bits_ul = 8 * sizeof(unsigned long int);

  if (!power)
    return 1;

  unsigned long int result = 2;

  return (unsigned long int) pow(2, power % modulo) % modulo;

  return result;
}


int main() {
  int power = 6;
  unsigned int modulo = 7;

  printf("2^%d = %.0f %% %d = %ld\n", power, pow(2, power), modulo, twopowmod(power, modulo));
  return 0;
}
