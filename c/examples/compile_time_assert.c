#include <stdlib.h>

#define CT_ASSERT(x) do { char c[(x ? 1 : -1)] __attribute__((unused)); } while(0)

int main() {
  CT_ASSERT(sizeof(int) > sizeof(char));
  CT_ASSERT(sizeof(double) > sizeof(float));

  system("PAUSE");
  return 0;
}
