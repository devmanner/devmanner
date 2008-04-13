#include <iostream>

using namespace std;

class Vehicle {
public:
  virtual void start() { cout << "Vehicle::start()" << endl; }
  virtual void stop() { cout <<  "Vehicle::stop()" << endl; }
};

class Car : public Vehicle {
public:
  void start() { cout << "Car::start()" << endl; }
  void stop() { cout <<"Car::stop()" << endl; }
};

class Boat: public Vehicle {
public:
  void start() { cout << "Boat::start()" << endl; }
  void stop() { cout << "Boat::stop()" << endl; }
};


int main() {
  Vehicle *v1 = new Car;
  Vehicle *v2 = new Boat;

  v1->start();
  v2->start();

  v1->stop();
  v2->stop();
  
  delete v1;
  delete v2;
  return 0;
}
