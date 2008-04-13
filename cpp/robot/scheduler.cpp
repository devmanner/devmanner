#include "scheduler.h"

bool Scheduler::deleteRobot(Robot *p) {
  list<Robot *>::iterator itr = robots.begin();
  for (; itr ; ++itr)
    if (*itr == p)
      break;
  if (itr) {
    robots.erase(itr);
    return true;
  }
  return false;
}

Scheduler::Scheduler(int n=0) {
  for (int i = 0; i < n; ++i)
    robots.push_back(new Robot());
}
