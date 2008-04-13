#include <stdio.h>

void sort(int *a, int n);
int findMaxIndex(int *a, int n);
void swap(int *a, int *b);

int main () {
  int i;
  int array[] = {5, 8, 2, 1, 3, 6, 10, 4, 9, 7};
  sort(array, 10);
  for (i = 0; i < 10; i++)
    printf("> %d\n", array[i]);
  return 0;
}

/* Sortera listan a med n element. */
void sort(int *a, int n) {
  int max;
  if (n == 1)
    return;
  max = findMaxIndex(a, n);
  swap(&a[max], &a[n-1]);
  sort(a, n - 1);
}

/* Leta upp vilket index max-elementet har. */
int findMaxIndex(int *a, int n) {
  int i, max = 0;
  for (i = 0; i < n; i ++)
    if (a[i] >= a[max])
      max = i;
  return max;
}

/* Byt plats på två element. */
void swap(int *a, int *b) {
  int temp = *a;
  *a = *b;
  *b = temp;
}
