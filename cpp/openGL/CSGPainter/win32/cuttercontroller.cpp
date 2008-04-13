#include "shape.h"
#include "cuttercontroller.h"
#include "csgpainter.h"

void CutterController::adjustMaxMin() {
  double d = 0.0; // To avoid a stoopid warning...
  if (m_max.m_x < m_min.m_x){
    d = m_max.m_x;
    m_max.m_x = m_min.m_x;
    m_min.m_x = d;
  }
  if (m_max.m_y < m_min.m_y) {
    d = m_max.m_y;
    m_max.m_y = m_min.m_y;
    m_min.m_y = d;
  }
  if (m_max.m_z < m_min.m_z){
    d = m_max.m_z;
    m_max.m_z = m_min.m_z;
    m_min.m_z = d;
  }

	float c[] = {.5,.5,.9};
	Shape *b = new StraightBox(m_min, m_max, c, true);
	b->create();
	CSGPainter::getInstance().add(b);
}

CutterController::CutterController() :
  m_pos(0, 0, 0), /* We always start at 0,0,0. */
  m_min(), /* UNDEFINED_VALUE */
  m_max(), /* UNDEFINED_VALUE */
  m_speed(0), /* No spped. */
  m_rotDirection(5), /* M5 is stopped */
  m_tool(0), 
  m_orientMode(17), /* Default = G17*/
  /*m_isAbs(true),*/
  m_inchMode(false), /* Default is millimeters. */
  m_cooling(false), /* Cooling is off. */
  m_feed(0.0) /* No feed set. */
  { 
		ifstream source("../tooltable.txt");
		
		if(!source)
			throw new FileNotFoundException("../tooltable.txt");
		
		char buf[80];
		source.getline(buf, 80); // disgard the first line!
		
		int no = 0;
		double lenght = 0;
		double radius = 0;
		while(source >> no){
			source >> lenght;
			source >> radius;
			m_tooltable.push_back(new CutterTool(no,lenght, radius));
		}
#ifdef _DEBUG_MODE_
		for(int i=0; i < m_tooltable.size(); i++)
			m_tooltable[i]->print();		
#endif
}

CutterController::~CutterController(){
	for(int i=0; i < m_tooltable.size(); i++)
		delete m_tooltable[i];
}

void CutterController::reset() {
	// Reset all values to initial values.
	m_pos.m_x = m_pos.m_y = m_pos.m_z = 0;
  m_min = Vertex();		/* UNDEFINED_VALUE */
  m_max = Vertex();		/* UNDEFINED_VALUE */
  m_speed = 0;				/* No spped. */
  m_rotDirection = 5; /* M5 is stopped */
  m_tool = 0 ;				/* Initial tool */
  m_orientMode = 17;	/* Default = G17 */
  m_inchMode = false;	/* Default is millimeters. */
  m_cooling = false;	/* Cooling is off. */
  m_feed = 0.0;				/* No feed set. */
}

Vertex CutterController::getPos(){ 
  return m_pos;		
}
void CutterController::setPos(Vertex p){
#ifdef _DEBUG_MODE_
  printf("setting pos: ");p.print();printf("\n");
#endif
  m_pos = p;
}

Vertex CutterController::getMin(){ 
  return m_min;		
}

void CutterController::setMin(Vertex m){
#ifdef _DEBUG_MODE_
  printf("setting min: "); m.print();printf("\n");
#endif
  m_min = m;
  if (m_max.m_x != UNDEFINED_VALUE &&
			m_max.m_y != UNDEFINED_VALUE &&
			m_max.m_z != UNDEFINED_VALUE)
    adjustMaxMin();
}

Vertex CutterController::getMax(){ 
  return m_max;		
}
void CutterController::setMax(Vertex m){
#ifdef _DEBUG_MODE_
  printf("setting max: "); m.print();printf("\n");
#endif
  m_max = m;
  if (m_min.m_x != UNDEFINED_VALUE &&
			m_min.m_y != UNDEFINED_VALUE &&
			m_min.m_z != UNDEFINED_VALUE)
    adjustMaxMin();
}

int CutterController::getSpeed(){ 
  return m_speed;	
}
void CutterController::setSpeed(int s){
#ifdef _DEBUG_MODE_
  printf("setting speed: %d\n", s);
#endif
  m_speed = s;
}

double CutterController::getFeed(){
  return m_feed;
}
void CutterController::setFeed(double f){
#ifdef _DEBUG_MODE_
  printf("setting feed: %.2f\n", f);
#endif
  m_feed = f;
}  

CutterTool CutterController::getTool(){
  return *m_tooltable[m_tool];
}
void CutterController::setTool(int t){
#ifdef _DEBUG_MODE_
  printf("setting tool: %d\n", t );
	m_tooltable[t]->print();
#endif
	if(t < m_tooltable.size())
		m_tool = t;
}

void CutterController::defineTool(CutterTool t) {
#ifdef _DEBUG_MODE_
  printf("Updating tool: ");t.print();printf("\n");
#endif
}

/*  
bool isAbs() {
  return m_isAbs;
}
void setAbs(bool b) {
  cout << "Setting absolute measurements to: " << ((b) ? "true" : "false") << endl;
  m_isAbs = b;
}
*/  

void CutterController::setOrientationMode(int m) {
  m_orientMode = m;
#ifdef _DEBUG_MODE_
  printf("Setting Orientation mode (Planval) to: %d\n", m );
#endif
}
int CutterController::getOrientationMode() {
  return m_orientMode;
}

void CutterController::setDirection(int d) {
  m_rotDirection = d;
#ifdef _DEBUG_MODE_
  printf("Setting direction to: %d\n", d);
#endif
}
int CutterController::getDirection() {
  return m_rotDirection;
}

void CutterController::setInchMode(bool b) {
#ifdef _DEBUG_MODE_
  printf("Setting inch-mode to: %s\n", (b) ? "true" : "false");
#endif
  m_inchMode = b;
}
bool CutterController::getInchMode() {
  return m_inchMode;
}

void CutterController::setCooling(bool b) {
  m_cooling = b;
}
bool CutterController::getCooling() {
  return m_cooling;
}

