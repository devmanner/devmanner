#include "common.h"
#include "bintree.h"

void Print(TreeEntry entry);
void ReadFile(char *fname, Tree T);

main () {
	Tree mytree;

	clrscr();
	CreateTree(&mytree);

	ReadFile("tele.txt", mytree);

	Traverse(mytree, Print);

	ClearTree(mytree);
	getch();
 	return 0;
}

void Print(TreeEntry entry) {
	printf("%s\t%s\t0%d-%ld\n", entry.lname, entry.fname, entry.ac, entry.tpn);
}

void ReadFile(char *fname, Tree T) {
	TreeEntry tmp;
	FILE *fp;

	fp = fopen(fname, "r");
	if (!fp)
		Error(strcat("Kan inte ”ppna filen: ", fname));
	while (!feof(fp)) {
		if (fscanf(fp, "%s %s %d-%ld", tmp.fname, tmp.lname, &tmp.ac, &tmp.tpn) != 4)
			break;
		Insert(T, tmp);
	}
	fclose(fp);
}