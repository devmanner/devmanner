#include "cutterlib.h"

double toDeg(const double &x){ 
	return (x*(180 / M_PI)); 
}

double absd(const double &x){
	return (x > 0)?x:-x;
}