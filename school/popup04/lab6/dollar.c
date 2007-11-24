#include <stdio.h>
#include <string.h>
#include <assert.h>

const char d[] = "ABCDEFGHIJKL";

void rem(char *from, char *what) {
  for (; *what; ++what)
    from[*what] = 1;
}

/* 0 is exists 1 is dont exist. */
char heavy[256];
char light[256];
char unw[256];

int main() {
  int n_tc;
  scanf("%d ", &n_tc);
  while (n_tc--) {
    int i;
    char c;
    for (i = 0; i < 3; ++i) {
      char buff[128];
      char *left, *right, *dir;
      fgets(buff, 128, stdin);
      buff[strlen(buff)-1] = '\0';

      /* Fetch the three parts of the string. */
      left = strtok(buff, " ");
      right = strtok(NULL, " ");
      dir = strtok(NULL, " ");
      strtok(NULL, " ");

      rem(unw, left);
      rem(unw, right);
      
      if (!strcmp(dir, "even")) {	
	rem(light, left);
	rem(light, right);
	rem(heavy, left);
	rem(heavy, right);
      }
      else if (!strcmp(dir, "up")) {
	char c;
	for (c = 'A'; c <= 'L'; ++c) {
	  if (strchr(left, c) == NULL && strchr(right, c) == NULL)
	    light[c] = heavy[c] = 1; /* Remove. */
	}
	/*
	  char tmp[256] = {0};
	  remove(tmp, left);
	  remove(tmp, right);
	  remove(light, tmp);
	  remove(heavy, tmp);
	*/
	rem(light, left);
	rem(heavy, right);
      }
      else if (!strcmp(dir, "down")) {
	for (c = 'A'; c <= 'L'; ++c) {
	  if (strchr(left, c) == NULL && strchr(right, c) == NULL)
	    light[c] = heavy[c] = 1; /* Remove. */
	}

	rem(light, right);
	rem(heavy, left);
      }
      else
	assert(0 && "unknown direction!");
    }
 
    /* Remove unweighted coins. */
    for (c = 'A'; c <= 'L'; ++c) {
      if (unw[c] == 0)
	light[c] = heavy[c] = 1;
    }

    for (c = 'A'; c <= 'L'; ++c) {
      if (heavy[c] == 0) {
	printf("%c is the counterfeit coin and it is heavy.\n", c);
      }
      else if (light[c] == 0) {
	printf("%c is the counterfeit coin and it is light.\n", c);
      }
      /* Reset the sets. */
      unw[c] = light[c] = heavy[c] = 0;
    }
  }
  return 0;
}
