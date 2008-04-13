#ifndef _SCHEDULER_H_
#define _SCHEDULER_H_

#include <list>
#include "payload.h"

using namespace std;

class Scheduler {
 private:
  list<Payload *> todo;
  list<Robot *> robots;
  
 public:
  Scheduler(int n_robots=0);
  void addRobot(Robot *r) { robots.push_back(r); }
  bool deleteRobot(Robot *);

  // The robots use this function to get a job.
  mission* requestWork();

  // Method used to register external missions.
  void addMission(mission *);
};

#endif
