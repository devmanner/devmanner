#include "common.h"
#include "queue.h"

int QueueSize(Queue *q) {
	return q->size;
}

void QueueFront(QueueEntry *x, Queue *q) {
	if(!QueueEmpty(q))
		*x = q->head->value;
	else
		Warning("Det finns inget ”versta v„rde. K”n „r tom.");
}


void Append(QueueEntry x, Queue *q) {
	nodeT *p, *hp;
	int register cnt;

	if (QueueFull(q)) {
		Warning("K”n „r full inget l„ggs p†.");
		return;
	}
	else {
		p = malloc(sizeof(nodeT));
		p->value = x;
		p->next = NULL;


		for(hp = q->head; hp->next != NULL; hp = hp->next)
			;

//		hp = q->head;

//		for (cnt = 1; cnt < q->size; cnt ++)
//			hp = hp->next;

		if (hp->next)
			Warning("Inte en null pekare.");

		hp->next = p;
		q->size ++;
	}
}


/*void Append(QueueEntry x, Queue *q) {
	nodeT *p;
	if (QueueFull(q)) {
		Warning("K”n „r full inget l„ggs p†.");
		return;
	}
	else {
		p = malloc(sizeof(nodeT));
		p->value = x;
		p->next = q->head;
		q->head = p;
		q->size ++;
	}
}
*/

void Serve(QueueEntry *x, Queue *q) {
	nodeT *p;
	if (QueueEmpty(q)) {
		Warning("K”n „r tom det g†r inte att ta bort n†got.");
		return;
	}
	p = q->head;
	q->head = q->head->next;
	q->size --;
	*x = p->value;
	free(p);
}

Boolean QueueEmpty(Queue *q) {
	if (q->head == NULL || q->def == 0)
		return TRUE;
	return FALSE;
}

Boolean QueueFull(Queue *q) {
	nodeT *p;
	Boolean ret_value;

	p = malloc(sizeof(nodeT));
	ret_value = (p ? FALSE : TRUE);
	free(p);
	return ret_value;
}

void CreateQueue(Queue *q) {
	q->size = 0;
	q->head = NULL;
	q->def = 1;
}

void ClearQueue(Queue *q) {
	nodeT *p, *pre;

	for (p = q->head; p; ) {
		pre = p;
		p = p->next;
		free(pre);
	}
	q->head = NULL;
	q->size = 0;
}

void TraverseQueue(Queue *q, void(*visit)(QueueEntry x)) {
	int register cnt;
	nodeT *p = q->head;

	for (cnt = 1; cnt <= q->size; cnt ++) {
		visit(p->value);
		p = p->next;
	}
}

