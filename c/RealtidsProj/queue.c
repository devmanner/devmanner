#include <stdio.h>

#define Q_MAXSIZE 10

typedef struct _QData {
  int amp;
  int dir;
} QData;

typedef struct _Queue {
  QData data[Q_MAXSIZE];
  int front, back;
} Queue;

/* Can be used to clear the queue */
void q_init(Queue *q) { 
  q->front = q->back = 0;
}

int q_isEmpty(Queue *q) {
  return (q->front == q->back);
}

int q_isFull(Queue *q) {
  return ((q->back+1) % Q_MAXSIZE == q->front);
}

/* Returns success, that is 0 if full. */
int q_append(Queue *q, QData *d) {
  if (q_isFull(q))
    return 0;
  q->data[q->back] = *d;
  q->back = (q->back+1) % Q_MAXSIZE;
  return 1;
}

/* Returns success, that is 0 if empty. */
int q_serve(Queue *q, QData *d) {
  if (q_isEmpty(q))
    return 0;
  *d = q->data[q->front];
  q->front = (q->front + 1) % Q_MAXSIZE;
  return 1;
}

void print(Queue *q) {
  int i;
  int around = (q->front > q->back);
  for (i = q->front; i < q->back || around; i = (i+1) % Q_MAXSIZE) {
    if (i == 0 && around)
      around = 0;
    printf("Node: %d -> %d, %d\n", i, q->data[i].amp, q->data[i].dir);
  }
}


int main() {
  int i;
  Queue q;
  q_init(&q);

  printf("Queue is: %s\n", (q_isFull(&q)) ? "Full" : "not full");
  printf("Queue is: %s\n", (q_isEmpty(&q)) ? "Empty" : "not empty");

  for (i = 0; i < 10; ++i) {
    QData d; d.amp = i; d.dir = 10-i;
    if (!q_append(&q, &d))
      printf("Failed to append!\n");
    else
      printf("Appending: %d, %d\n", d.amp, d.dir);
  }

  print(&q);

  for (i = 0; i < 5; ++i) {
    QData d;
    if (!q_serve(&q, &d))
      printf("Failed to serve!\n");
    else
      printf("Serving: %d, %d\n", d.amp, d.dir);
  }
  print(&q);

  for (i = 0; i < 10; ++i) {
    QData d; d.amp = i; d.dir = 10-i;
    if (!q_append(&q, &d))
      printf("Failed to append!\n");
    else
      printf("Appending: %d, %d\n", d.amp, d.dir);
  }
  print (&q);


  printf("Queue is: %s\n", (q_isFull(&q)) ? "Full" : "not full");
  printf("Queue is: %s\n", (q_isEmpty(&q)) ? "Empty" : "not empty");

  return 0;
}
