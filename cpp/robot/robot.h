#ifndef _ROBOT_H_
#define _ROBOT_H_

#include <iostream>
#include "scheduler.h"
#include "payload.h"

using namespace std;

class Roboot { // Skall �rva fr�n tr�dklassen och �verlagra threadMain()
 private:
  list<Mission *> *todo;

 public:

};

#endif
