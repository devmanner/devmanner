#include <stdio.h>

void init() __attribute__((constructor));

void init() {
  printf("%s()\n", __func__);
}

int main() {

  printf("%s()\n", __func__);
  return 0;
}
