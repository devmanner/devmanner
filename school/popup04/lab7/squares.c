#include <stdio.h>

#define GRID_SIZE 2049


char grid[GRID_SIZE][GRID_SIZE];

void reset(void) {
  int r, c;
  for (r = 0; r < GRID_SIZE; ++r)
    for (c = 0; c < GRID_SIZE; ++c)
      grid[r][c] = 0;
}

void draw_square(int k, int c_row, int c_col) {
  int r, c;
  int halfk = k / 2;
  
  if (k == 1) {
    grid[c_row][c_col]++;
    return;
  }

  for (r = c_row - k; r <= c_row + k; ++r)
    for (c = c_col - k; c <= c_col + k; ++c)
      grid[r][c]++;

  draw_square(halfk, c_row-k, c_col-k);
  draw_square(halfk, c_row-k, c_col+k);
  draw_square(halfk, c_row+k, c_col-k);
  draw_square(halfk, c_row+k, c_col+k);
}

void print(void) {
  int r, c;
  for (r = 0; r < GRID_SIZE; ++r) {
    for (c = 0; c < GRID_SIZE; ++c)
      printf("%d", grid[r][c]);
    printf("\n");
  }
}

int main() {
  int k, x, y;
  while (scanf("%d %d %d", &k, &x, &y) != EOF && k && x && y) {
    reset();
    draw_square(k, GRID_SIZE/2, GRID_SIZE/2);

    printf("%d\n", grid[x][y]);
  }
  return 0;
}
