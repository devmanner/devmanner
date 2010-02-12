#include "common.h"
#include "list.h"

//programmet ska fixa en ordnad lista.....
void Intro(void);
char GetCommand(void);
void DoCommand(char, List *list);
void PrintKey(ListEntry x);

void main(){
	List mylist;
	CreateList(&mylist);

   Intro();

	while(TRUE)
   	DoCommand(GetCommand(), &mylist);
}

//-------------------------------------------------------Intro
void Intro(void){
	clrscr();
	printf(   "\t***********************************************"
			  "\n\t*Detta program behandlar en ordnad lista.     *"
           "\n\t*				              *"
           "\n\t*Av: Kristoffer Roup‚ och Tomas Mannerstedt   *"
           "\n\t***********************************************\n");
}

//-------------------------------------------------------GetCommand
char GetCommand(void){
	char command;

   printf("\n\t[I]nsert entry\t[P]rint list\t[S]ize of list\n"
		"\t[C]lear list\t[D]elete entry\n\t[F]ind\t[Q]uit\n"
		"\n\tSelect command and press [ENTER]: ");
	while(TRUE){
		while((command = getchar()) == '\n')
			;
		command = tolower(command);
	if( command == 'i' || command == 'p' || command == 's'||
	    command == 'c' || command == 'd' || command == 'q'||
       command == 'f'){
		while(getchar() != '\n')
			;
		return command;
	    }
	printf("\tPlease enter a valid command: ");
	}
}

//-------------------------------------------------------DoCommand
void DoCommand(char command, List *list){
	ListEntry x;
   int elem;

	switch(command){

		case 'i' :
				printf("\tSkriv in entry: ");
				scanf(" %d", &x.key);
				InsertOrder(list, x);
				break;

		case 'p' :
				printf("\n\tListan ar: ");
				TraverseList(list, PrintKey);
				printf("\n");
				break;

		case 's' :
				printf("\n\tListan ar %d element stor", ListSize(list));
				printf("\n");
				break;

		case 'd' :
				printf("\tMata in vilket element du vill ta bort. (0-%d)\n\t> ", MAXSIZE);
				scanf("%d", &elem);
				printf("\n\tDu tog bort: ");
				PrintKey(Serve(list, elem));
				printf("\n");
				break;

		case 'c' :
				ClearList(list);
				printf("\n\tListan „r nu tom!");
				break;

		case 'f' :
				printf("\tMata in ett element att s”ka efter.\n\t> ");
				scanf("%d", x.key);
				elem = SeqSearch(list, x.key);
				if (elem == -1)
					Warning("\tElementet finns inte i listan.");
				else
					printf("\tElementet: %d finns i listan på index: %d", x.key, elem);
				break;

		case 'q' :
				DeleteList(list);
				exit(0);
		}
}

//--------------------------------------------------------PrintKey
void PrintKey(ListEntry x){
	printf(" %d", x.key);
}

