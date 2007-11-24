#include <stdio.h>
#include <assert.h>
#include <ctype.h>

int npers;

typedef unsigned int pizza_t;

const pizza_t LASTPIZZA = 0xFFFF;
const pizza_t FIRSTPIZZA = 0x0;
const pizza_t NOPIZZA = 1 << 16;

/* Ingredients */
const pizza_t A = 1 << 0;
const pizza_t B = 1 << 1;
const pizza_t C = 1 << 2;
const pizza_t D = 1 << 3;
const pizza_t E = 1 << 4;
const pizza_t F = 1 << 5;
const pizza_t G = 1 << 6;
const pizza_t H = 1 << 7;
const pizza_t I = 1 << 8;
const pizza_t J = 1 << 9;
const pizza_t K = 1 << 10;
const pizza_t L = 1 << 11;
const pizza_t M = 1 << 12;
const pizza_t N = 1 << 13;
const pizza_t O = 1 << 14;
const pizza_t P = 1 << 15;

pizza_t ingredients['P' + 1];
void init() {
  ingredients['A'] = A;
  ingredients['B'] = B;
  ingredients['C'] = C;
  ingredients['D'] = D;
  ingredients['E'] = E;
  ingredients['F'] = F;
  ingredients['G'] = G;
  ingredients['H'] = H;
  ingredients['I'] = I;
  ingredients['J'] = J;
  ingredients['K'] = K;
  ingredients['L'] = L;
  ingredients['M'] = M;
  ingredients['N'] = N;
  ingredients['O'] = O;
  ingredients['P'] = P;
}

void print_pizza(const pizza_t pizza);

struct Person {
  pizza_t plus;
  pizza_t minus;  
};

struct Person create_person(const char *r) {
  struct Person pers = {0, 0};
  const char *sign = r;
  const char *c = r+1;
  for (; *sign != ';' && *c; sign += 2, c += 2) {
    assert(isupper(*c) || *sign == '-' || *sign == '+');
    if (*sign == '+')
      pers.plus = pers.plus | ingredients[*c]; 
    else
      pers.minus = pers.minus | ingredients[*c]; 
  }
  return pers;
}


void print_pizza(const pizza_t pizza) {
  if (pizza & A) putchar('A');
  if (pizza & B) putchar('B');
  if (pizza & C) putchar('C');
  if (pizza & D) putchar('D');
  if (pizza & E) putchar('E');
  if (pizza & F) putchar('F');
  if (pizza & G) putchar('G');
  if (pizza & H) putchar('H');
  if (pizza & I) putchar('I');
  if (pizza & J) putchar('J');
  if (pizza & K) putchar('K');
  if (pizza & L) putchar('L');
  if (pizza & M) putchar('M');
  if (pizza & N) putchar('N');
  if (pizza & O) putchar('O');
  if (pizza & P) putchar('P');
}

void print_pers(const struct Person *pers) {
  int i;
  for (i = i; i < npers; ++i) {
    printf("Person #%d: +", i);
    print_pizza(pers[i].plus);
    printf(" -");
    print_pizza(pers[i].minus);
    printf("\n");
  }
}

#define ok_pizza(pizza, p) (pizza & p.plus || ~pizza & p.minus)

int get_pizza(const struct Person *pers) {
  pizza_t pizza;
  int i, ok;
  for (pizza = FIRSTPIZZA; pizza <= LASTPIZZA; ++pizza) {
    ok = 1;
    for (i = 0; i < npers; ++i) {
      if (!ok_pizza(pizza, pers[i])) {
	ok = 0;
	break;
      }
    }
    if (ok)
      return pizza;
  }
  return NOPIZZA;
}

int main() {
  char buff[64];
  struct Person pers[128];
  init();
  npers = 0;
  while (fgets(buff, 64, stdin)) {
    if (buff[0] == '.') {
      /* Calculate and output toppings. */
      pizza_t pizza = get_pizza(pers);      
      if (pizza != NOPIZZA) {
	printf("Toppings: ");
	print_pizza(pizza);
      }
      else
	printf("No pizza can satisfy these requests.");
      putchar('\n');
      /* print(pers); */
      npers = 0;
    }
    else {
      pers[npers++] = create_person(buff);
    }
  }
  return 0;
}
