#ifndef QUEUE_H
#define QUEUE_H

//#include <stdio.h>
#include "common.h"

typedef struct {
	char name;
	int time;
} QueueEntry;

typedef struct node {
	struct node *next;
	QueueEntry value;
} nodeT;

typedef struct {
	nodeT *head;
	int size;
	int def; // Defined or not.
} Queue;

// Kollar om k”n „r tom/full.
Boolean QueueEmpty(Queue *q);
Boolean QueueFull(Queue *q);

// T”mmer k”n.
void ClearQueue(Queue *q);

// Skapar en tom k”.
void CreateQueue(Queue *q);

// Returnerar f”rsta v„rdet i k”n.
void QueueFront(QueueEntry *x, Queue *q);

// Genoml”p k”n.
void TraverseQueue(Queue *q, void(*visit)(QueueEntry x));

// L„gg till nod.
void Append(QueueEntry x, Queue *q);

// Ta bort.
void Serve(QueueEntry *x, Queue *q);

// Return storlek.
int QueueSize(Queue *q);

#endif
