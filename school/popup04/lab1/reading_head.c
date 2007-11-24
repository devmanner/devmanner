#include <stdio.h>
#include <stdlib.h>

struct file {
  int curr_pos;
  int len;
};

int main () {
  int ntc, tc;
  scanf("%d", &ntc);

  for (tc = 0; tc < ntc; ++tc) {
    int no_files, no_blocks, no_steps, total=0, i;
    struct file *files;

    scanf("%d %d", &no_files, &no_blocks);
    if (no_files == -1)
      break;

    files = malloc(sizeof(struct file) * no_files);

    for (i = 0; i < no_files; ++i)
      scanf("%d", &(files[i].len));
    for (i = 0; i < no_files; ++i)
      scanf("%d", &(files[i].curr_pos));
    scanf("%d", &no_steps);
    
    /* HACK HACK... */
    if (no_files == 1) {
      /* i is the number of read blocks -1. */
      for (i = 1; i < no_steps; ++i) {
	++files[0].curr_pos;
	if (files[0].curr_pos > files[0].len) {
	  total += files[0].len - 1;
	  files[0].curr_pos = 1;
	}
	else
	  ++total;
      }
      printf("%d\n", total);
      free(files);
      continue;
    }
    /* End of HACK HACK */

    for (i = 1; i < no_steps; ++i) {
      /* Start over with the first file. */
      if (i % no_files == 0) {
	int j;
	for (j = i-1; j > 0; --j)
	  total += files[j].len;
	total += files[i].curr_pos;
	total += files[0].len - files[0].curr_pos;
      }
      else
	total += files[(i-1)%no_files].len - files[(i-1)%no_files].curr_pos + files[i%no_files].curr_pos;

      printf("read: %d total: %d\n", i, total);

      files[(i-1)%no_files].curr_pos++;
      /* Did we reach EOF. */
      if (files[(i-1)%no_files].curr_pos > files[(i-1)%no_files].len)
	files[(i-1)%no_files].curr_pos = 1;
    }
    printf("%d\n", total);
    free(files);
  }

  return 0;
}
