#include <string>

using namespace std;

const int BUFF_SIZE = 81;

void strip(char *s) {
  int i = strlen(s);
  while (s[i] == '\n')
    --i;
  s[i-1] = '\0';
}

void fill(char *s) {
  for (int i = strlen(s); i < BUFF_SIZE; ++i)
    s[i] = '?';
  s[BUFF_SIZE] = '\0';
}

int main() {
  char plain[BUFF_SIZE];
  char cypher1[BUFF_SIZE];
  char cypher2[BUFF_SIZE];
  while (fgets(plain, BUFF_SIZE, stdin)) {
    if (!strcmp(plain, "#\n"))
      break;
    strip(plain);
    fill(plain);

    fgets(cypher1, BUFF_SIZE, stdin);
    strip(cypher1);
    fill(cypher1);

    fgets(cypher2, BUFF_SIZE, stdin);
    strip(cypher2);
    fill(cypher2);



    /* Find smallest value of k. */
    unsigned int k;
    bool match;
    for (k = 1; k <= strlen(plain); ++k) {
      match = true;
      /* Zero-counted part of the plaintext. */
      for (unsigned int part = 0; part*k < strlen(plain); ++part) {
	/* Get substrings and compare them sorted. */
	char plain_substr[k+1];
	strncpy(plain_substr, &(plain[k*part]), k);
	plain_substr[k] = '\0';
	char cypher_substr[k+1];
	strncpy(cypher_substr, &(cypher1[k*part]), k);
	cypher_substr[k] = '\0';

	printf("Substrings: <%s> <%s>\n", plain_substr, cypher_substr);

	sort(plain_substr, &(plain_substr[k]));
	sort(cypher_substr, &(cypher_substr[k]));
	/* Break if unequal. */
	if (strcmp(plain_substr, cypher_substr)) {
	  match = false;
	  break;
	}
      }
      if (match)
	break;
    }
    if (match) {
      printf("k = %d\n", k);
      
      /* Find the permutation. */
      int perm[k];
      int inv_perm[k];
      char decr[strlen(cypher2)+1];

      /* Create the permutation. */
      for (unsigned int i = 0; i < k; ++i)
	perm[i] = 1 + distance(cypher1, find(cypher1, &(cypher1[strlen(cypher1)]), plain[i]));
     
      /* Create the inverse permutation. */
      for (unsigned int i = 0; i < k; ++i)
	inv_perm[perm[i]] = i;

      /* Decrypt the cypher2 string. */
      

      decr[strlen(cypher2)] = '\0';

      printf("%s\n", decr);
      
    }
    else {
      printf("%s", cypher2);
    }

  }
  return 0;
}
