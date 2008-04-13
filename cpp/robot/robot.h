#ifndef _ROBOT_H_
#define _ROBOT_H_

#include <iostream>
#include "scheduler.h"
#include "payload.h"

using namespace std;

class Roboot { // Skall ärva från trådklassen och överlagra threadMain()
 private:
  list<Mission *> *todo;

 public:

};

#endif
