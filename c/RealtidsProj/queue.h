#ifndef _QUEUE_H_
#define _QUEUE_H_

#define Q_MAXSIZE 10

/* Redeclare this if uou want another queue contens. */
typedef struct _QData {
  int x_amp, y_amp, z_amp;
} QData;

/* The queue itself. */
typedef struct _Queue {
  QData data[Q_MAXSIZE+1]; /* One extra element. */
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

/* Shall _not_ be included in final release */
void print(Queue *q) {
  int i;
  int around = (q->front > q->back);
  printf("Queue is:\n");
  for (i = q->front; i < q->back || around; i = (i+1) % Q_MAXSIZE) {
    if (i == 0 && around)
      around = 0;
    printf("Node: %d -> %d, %d, %d\n", i, q->data[i].x_amp, q->data[i].y_amp, q->data[i].z_amp);
  }
}

#endif
