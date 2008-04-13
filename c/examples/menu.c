#include <stdio.h>

// Skriv ut en meny
void MenuDisplay (int variable) {
  printf("This is a menu...%d\n", variable);
}

// Spara en funktion (on func är satt) och returnera denna.
void ( *PointDisplay( void(*func)(int) ) ) (int) {
  static void(*f)(int) = NULL;
  if (func)
    f = func;
  return f;
}

// Ropa på funktionen som tidigare var satt med PointDisplay
void Display(int value) {
  (PointDisplay(NULL))(value);
}

int main () {
  PointDisplay(MenuDisplay); 
  Display(10);
    
  return 0;
}
