#include <algorithm>
#include <cstdio>

using namespace std;

int main() {
  int n;
  while (fscanf(stdin, "%d", &n)) {
    int i;
    int costs[n];
    int mean = 0;

    if (!n)
      break;

    for (i = 0; i < n; ++i) {
      float temp;
      fscanf(stdin, "%f", &temp);
      /* Recalc everything to cents. */
      temp *= 100.0;
      costs[i] = (int) (temp);
      mean += costs[i];
    }
    mean /= n;
    sort(costs, &(costs[n]));

#ifdef DEBUG
    printf("In the beginning: mean: %d\n", mean);
    for (i = 0; i < n; ++i)
      printf("%d ", costs[i]);
    printf("\n\n");
#endif

    /* Do the exchange of money. */
    int total=0;
    int removed;

    while (mean < costs[n-1] - 1) {

#ifdef DEBUG
      for (i = 0; i < n; ++i)
	printf("%d ", costs[i]);
      printf("\n");
#endif
      removed = costs[n-1] - (mean + 1);
      total += removed;
      costs[n-1] = mean + 1;
      costs[0] += removed;
      sort(costs, &(costs[n]));
    }

#ifdef DEBUG
    printf("\n$%d\n", total);
#endif

    while ( *min_element(costs, &(costs[n])) + 1 < *max_element(costs, &(costs[n])) ) {
      removed = mean - *min_element(costs, &(costs[n]));
      total += removed;
      *min_element(costs, &(costs[n])) += removed;
      *max_element(costs, &(costs[n])) -= removed;
    }

    printf("$%.2f\n", total / 100.0);

#ifdef DEBUG
    for (i = 0; i < n; ++i)
      printf("%d ", costs[i]);
    printf("\n");
#endif

  }
  return 0;
}
