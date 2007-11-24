#include <algorithm>
#include <cstdio>
#include <cstring>

using namespace std;

void strip(char *s) {
  int i = strlen(s);
  while (s[i] == '\n')
    --i;
  s[i-1] = '\0';
}

int main() {
  char word1[1001], word2[1001];
  while(fgets(word1, 1001, stdin)) {
    fgets(word2, 1001, stdin);
    
    strip(word1);
    strip(word2);
    
    /*    
	  printf("<%s>, <%s>\n", word1, word2);
    */
    
    sort(word1, &(word1[strlen(word1)]));
    sort(word2, &(word2[strlen(word2)]));
    
    char common[1001];
    memset(common, 0, 1001);

    set_intersection(word1, &(word1[strlen(word1)]),
		     word2, &(word2[strlen(word2)]),
		     common);
    
    sort(common, &(common[strlen(common)]));
    printf("%s\n", common);
  }
  
  return 0;
}
