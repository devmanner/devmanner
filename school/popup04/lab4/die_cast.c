#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

int n_rows, n_cols;

char *acc(char* matrix, int row, int col) {
  return &(matrix[row*n_cols+col]);
}

char matrix[1024][1024];
int answer[1024];


#define print(x) \
do { \
  int __r, __c; \
  for (__r = 1; __r < n_rows+1; ++__r) { \
    for (__c = 1; __c < n_cols+1; ++__c) \
      putchar(x[__r][__c]); \
    putchar('\n'); \
  } \
} while (0)

int find_fst(char what, int *row, int *col) {
  int r = *row, c = *col;
  int first = 1;
  
  for (r = *row; r < n_rows+1; ++r) {
    for (c = (first) ? c : 0; c < n_cols+1; ++c) {
      if (matrix[r][c] == what) {
	*row = r;
	*col = c;
	return 1;
      }
    }
    first = 0;
  }
  return 0;
}

void merge_adj(int r, int c) {
#ifdef DBG
  printf("\n");
  print(matrix);
#endif

  if (matrix[r][c] == 'X') {
    matrix[r][c] = 'M';
    merge_adj(r+1, c);
    merge_adj(r-1, c);
    merge_adj(r, c+1);
    merge_adj(r, c-1);
  }
}


/* Merge duplicate X. */
int fixup(void) {
  int r=1, c=1;
  while (find_fst('X', &r, &c)) {
    int row=0, col=0, last_row=r, last_col=c;
    merge_adj(r, c);
    while (find_fst('M', &row, &col)) {
      matrix[row][col] = '*';
      /*      last_row = row;
	      last_col = col;*/
      row = col = 0;
    }
    matrix[last_row][last_col] = 'X';
    r = last_row, c = last_col + 1;
  }

  return 0;
}


int count(int r, int c) {
  int ret = 0;
  if (matrix[r][c] == 'X')
    ret += 1;

  matrix[r][c] = '.';

  if (matrix[r-1][c] != '.' && matrix[r-1][c] != '\0')
    ret += count(r-1, c);
  if (matrix[r][c+1] != '.' && matrix[r][c+1] != '\0')
    ret += count(r, c+1);
  if (matrix[r+1][c] != '.' && matrix[r+1][c] != '\0')
    ret += count(r+1, c);
  if (matrix[r][c-1] != '.' && matrix[r][c-1] != '\0')
    ret += count(r, c-1);
  return ret;
}

int int_cmp(const void*i1, const void *i2) {
  return *((int*)i1) > *((int*)i2);
}


int main() {
  int ntc = 1;
  while (scanf("%d %d ", &n_cols, &n_rows) != EOF && (n_rows || n_cols)) {
    int r, c, cnt;

    assert(n_rows < 1024 && n_cols < 1024 && "matrix too big");

    /* Read the input. */
    for (r = 0; r < n_rows; ++r) {
      char tmp;
      for (c = 0; c < n_cols; ++c) {
	scanf("%c", &tmp);
	if (tmp != '\n') {
	  tmp = (tmp != '.' && tmp != '*' && tmp != 'X') ? '.' : tmp;
	  matrix[r+1][c+1] = tmp;
	}
      }
      while (tmp != '\n')
	scanf("%c", &tmp);
    }

    /* Set a zero frame around the matrix. */
    for (r = 0; r < n_rows+2; ++r)
      matrix[r][0] = matrix[r][n_cols+1] = '\0';
    for (c = 0; c < n_cols+2; ++c)
      matrix[0][c] = matrix[n_rows+1][c] = '\0';

#ifdef DBG
    printf("\n");
    print(matrix);
#endif
    
    fixup(); 

#ifdef DBG
    printf("\nAfter merging:\n");
    print(matrix);
#endif
    
    for (cnt = 0, r = 1, c = 1; find_fst('*', &r, &c); ++cnt) {
      answer[cnt] = count(r, c);
    }

    for (r = 1, c = 1; find_fst('X', &r, &c); ++cnt) {
      answer[cnt] = count(r, c);
    }

    qsort(answer, cnt, sizeof(int), int_cmp);
    printf("Throw %d\n", ntc);
    for (r = 0; r < cnt; ++r)
      printf("%d ", answer[r]);
    if (!cnt)
      printf("0");
    printf("\n\n");
    ++ntc;
  }
  return 0;
}
