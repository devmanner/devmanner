/******************************
* Demo av Round-Robin schema. *
******************************/

#define BUFFERSIZE 10

#include "common.h"
#include "queue.h"

void roundRobin(Queue *q);

// Skriver ut hger till v„nster.
void printQueue(Queue *q);

// Skriver ut ett k” element;
void printElem(QueueEntry x);

// L„ser in ett antal jobb.
void getJobs(Queue *q);

// Skriver ut ett QueueEntry.
void print(QueueEntry x);

main() {
	Queue myQueue;
//	int cnt;

	CreateQueue(&myQueue);

	clrscr();
	getJobs(&myQueue);

//for (cnt = 0; cnt < 10; cnt ++) {
	printQueue(&myQueue);
//	printf("\n");
//}

//	roundRobin(&myQueue);


	ClearQueue(&myQueue);

	getch();
	return 0;
}

/*****************************************/

void roundRobin(Queue *q) {
	QueueEntry tmp;

	while (!QueueEmpty(q)) {
		printf("\n");
		printQueue(q);
		Serve(&tmp, q);
		tmp.time --;
		if(tmp.time > 0)
			Append(tmp, q);
	}
}

void getJobs(Queue *q) {
	QueueEntry tmp, *buffer;
	int cnt = 0, scan = 0;
	buffer = malloc(BUFFERSIZE * sizeof(char));

	printf("Mata in max tio jobb ett mellanslag mellan namn och tid.\nAvsluta med <ENTER>.\n");

	do {
		printf("> ");
		gets(buffer);
		scan = sscanf(buffer, "%c %d", &tmp.name, &tmp.time);
		cnt ++;
		if (scan != -1)
			Append(tmp, q);
	} while(scan != -1 && cnt < 10);
	if (cnt >= 10)
		Warning("Du har redan matat in max antal jobb.");
	free(buffer);
}

void printQueue(Queue *q) {
	gotoxy((q->size + 1) * 8, wherey());
	TraverseQueue(q, printElem);
}

void printElem(QueueEntry x) {
	gotoxy(wherex() - 13, wherey());
	printf("%c:%d  ", x.name, x.time);
}
