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
    int no_files, no_blocks, to_read, total=0, i;
    struct file *files;

    scanf("%d %d", &no_files, &no_blocks);
    if (no_files == -1)
      break;

    files = malloc(sizeof(struct file) * no_files);

    for (i = 0; i < no_files; ++i)
      scanf("%d", &(files[i].len));
    for (i = 0; i < no_files; ++i)
      scanf("%d", &(files[i].curr_pos));
    scanf("%d", &to_read);
    
    for (i = 1; i <= to_read; ++i) {
      /* i is #read. */
      total += files[(i-1)%no_files].len - files[(i-1)%no_files].curr_pos
	+ files[i%no_files].curr_pos;
	
      files[(i-1)%no_files].curr_pos = (files[(i-1)%no_files].curr_pos + 1)
	% files[(i-1)%no_files].len;
      


    }


    printf("%d\n", total);
    free(files);
  }

  return 0;
}
