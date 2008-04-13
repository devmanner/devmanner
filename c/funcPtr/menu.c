#include <stdio.h>

void f1(void){
  printf("f1()\n");
}
void f2(void){
  printf("f2()\n");
}
void f3(void){
  printf("f3()\n");
}
void f4(void){
  printf("f4()\n");
}

int main() {
  void (*funcs[])(void) = {f1, f2, f3, f4};
  int f;
  printf("Select a function (1-4): ");
  scanf("%d", &f);
  funcs[(f-1)%4]();
  return 0;
}
