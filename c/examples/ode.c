#include <ode/ode.h>

int main() {
  dWorldID w = dWorldCreate();

  dWorldSetGravity(w, 0, 0, -9.82);
  dWorldSetERP(w, 0.5);
  dWorldDestroy(w);

  return 0;
}
