#include "common.h"
#include "llist.h"

void fPrintWS(int n);
void PrintListEntry(ListEntry x);
void fPrintListEntry(ListEntry x);
void PrintToFile(char *fname, List *list);
void ReadFile(char *fname, List *list);

// Global filpekare.
FILE *fp;

main(int argc, char* argv[]) {
//main() {
	List myList;
   CreateList(&myList);
   clrscr();

//   ReadFile("d00.txt", &myList);
   ReadFile(argv[1], &myList);

   InsSort(&myList);
//   fp = stdout;
//   TraverseList(&myList, fPrintListEntry);

//   PrintToFile("out.txt", &myList);
   PrintToFile(argv[2], &myList);

   ClearList(&myList);
	getch();
	return 0;
}

void PrintToFile(char *fname, List *list) {

	fp = fopen(fname, "w+");
   if(!fp)
      Error(strcat("Kan inte öppna filen: ", fname));

   TraverseList(list, fPrintListEntry);
	fclose(fp);
}

void ReadFile(char *fname, List *list) {
	ListEntry tmp;

	fp = fopen(fname, "r");
   if(!fp)
      Error(strcat("Kan inte öppna filen: ", fname));

   while (!feof(fp)) {
	   if (fscanf(fp, "%s %s %c %d", &tmp.lname, &tmp.fname, &tmp.group, &tmp.left) <= 0)
      	break;
      strcpy(tmp.key, tmp.lname);
      InsertList(list, tmp);
   }
   fclose(fp);
}




void fPrintListEntry(ListEntry x) {
	fprintf(fp, "%s", x.key);
   fPrintWS(15 - strlen(x.key));

   fprintf(fp, "%s", x.lname);
   fPrintWS(12 - strlen(x.lname));

   fprintf(fp, "%s", x.fname);
   fPrintWS(13 - strlen(x.fname));

   fprintf(fp, "%c", x.group);
   fPrintWS(3);

   fprintf(fp, "%d\n", x.left);
}

void fPrintWS(int n) {
	int register cnt;
   for (cnt = 0; cnt < n; cnt ++)
   	fprintf(fp, " ");
}

void PrintListEntry(ListEntry x) {
   printf("%s", x.key);
   gotoxy(wherex() - strlen(x.key) + 15, wherey());
   printf("%s", x.lname);
   gotoxy(wherex() - strlen(x.lname) + 12, wherey());
   printf("%s", x.fname);
   gotoxy(wherex() - strlen(x.fname) + 13, wherey());
   printf("%c", x.group);
   gotoxy(wherex() + 2, wherey());
   printf("%d\n", x.left);
}

