#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include "queue.h"

/* Positions of the engines */
#define L1X 100
#define L1Y 100
#define L1Z 100
#define L2X 100
#define L2Y -100
#define L2Z 100
#define L3X -100
#define L3Y 100
#define L3Z 100
#define L4X -100
#define L4Y -100
#define L4Z 100

typedef struct _Position {
  int x, y, z;
} Position;

typedef struct _Message {
  int newlen;
  int rec;
} Message;

void can_send(Message *m) {
  printf("Sending message to %d: newlength: %d\n", m->rec, m->newlen);
}


int main() {
  Queue mess_q;
  q_init(&mess_q);	

  for(;;) {
    int i, values;
    Position curr_pos = {0, 0, 0};
    QData data;
    while (q_serve(&mess_q, &data)) {
      Message m;

      print(&mess_q);

      curr_pos.x += data.x_amp/4;
      curr_pos.y += data.y_amp/4;
      curr_pos.z += data.z_amp/4;
      
      m.newlen = sqrt(pow(abs(L1X-curr_pos.x), 2) + pow(abs(L1Y-curr_pos.y), 2) + pow(abs(L1Z-curr_pos.z), 2));
      m.rec = 1;
      can_send(&m);
      m.newlen = sqrt(pow(abs(L2X-curr_pos.x), 2) + pow(abs(L2Y-curr_pos.y), 2) + pow(abs(L2Z-curr_pos.z), 2));
      m.rec = 2;
      can_send(&m);
      m.newlen = sqrt(pow(abs(L3X-curr_pos.x), 2) + pow(abs(L3Y-curr_pos.y), 2) + pow(abs(L3Z-curr_pos.z), 2));
      m.rec = 3;
      can_send(&m);
      m.newlen = sqrt(pow(abs(L4X-curr_pos.x), 2) + pow(abs(L4Y-curr_pos.y), 2) + pow(abs(L4Z-curr_pos.z), 2));
      m.rec = 4;
      can_send(&m);
    }

      /* This is some testing stuff... This shall eg be an interrupt routine. */
    values = rand() % 5;
    for (i = 0; i < values; ++i) {
      data.x_amp = rand() % 512 - 255;
      data.y_amp = rand() % 512 - 255;
      data.z_amp = rand() % 512 - 255;
      if (q_append(&mess_q, &data))
	printf("Sent some movements...\n");
      else
	printf("Queue is full!\n");
    }

    sleep(2);
  }

return 0;
}

