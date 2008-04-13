#include "lab1.h"
#include "lab1_gl.h"

#include <qgroupbox.h>
#include <qbuttongroup.h>
#include <qradiobutton.h>

lab1_c::lab1_c(QWidget *_parent,const char *_szName)
: QHBox(_parent,_szName)
{
	lab1_gl_c *lab1_gl = new lab1_gl_c(this,0);
	lab1_gl->setMinimumSize(320,240);
	QVBox *Controls = new QVBox(this);
	QGroupBox *RotBox = new QGroupBox(3,Horizontal,"Rotation",Controls,0);
	QSlider *RotX = new QSlider(RotBox,0);
	QSlider *RotY = new QSlider(RotBox,0);
	QSlider *RotZ = new QSlider(RotBox,0);
	RotX->setRange(0,359);
	QObject::connect(RotX,SIGNAL(valueChanged(int)),lab1_gl,SLOT(setRotX(int)));
	RotX->setValue(0);
	RotY->setRange(0,359);
	QObject::connect(RotY,SIGNAL(valueChanged(int)),lab1_gl,SLOT(setRotY(int)));
	RotY->setValue(0);
	RotZ->setRange(0,359);
	QObject::connect(RotZ,SIGNAL(valueChanged(int)),lab1_gl,SLOT(setRotZ(int)));
	RotZ->setValue(0);

	QGroupBox *StepsBox = new QGroupBox(2,Horizontal,"Steps",Controls,0);
	QSlider *StepsX = new QSlider(StepsBox,0);
	QSlider *StepsY = new QSlider(StepsBox,0);
	StepsX->setRange(1,50);
	QObject::connect(StepsX,SIGNAL(valueChanged(int)),lab1_gl,SLOT(setStepsX(int)));
	StepsX->setValue(25);
	StepsY->setRange(1,50);
	QObject::connect(StepsY,SIGNAL(valueChanged(int)),lab1_gl,SLOT(setStepsY(int)));
	StepsY->setValue(25);
	
	QGroupBox *PeaksBox = new QGroupBox(2,Horizontal,"Peaks",Controls,0);
	QSlider *PeaksX = new QSlider(PeaksBox,0);
	QSlider *PeaksY = new QSlider(PeaksBox,0);
	PeaksX->setRange(0,10);
	QObject::connect(PeaksX,SIGNAL(valueChanged(int)),lab1_gl,SLOT(setPeaksX(int)));
	PeaksX->setValue(3);
	PeaksY->setRange(0,10);
	QObject::connect(PeaksY,SIGNAL(valueChanged(int)),lab1_gl,SLOT(setPeaksY(int)));
	PeaksY->setValue(2);

	QGroupBox *RendermodeBox = new QGroupBox(3,Vertical,"Rendermode",Controls,0);
	QButtonGroup *ButtonGroup1 = new QButtonGroup(3,Vertical,"Frontface Mode:",RendermodeBox,0);
	QRadioButton *Wireframe1 = new QRadioButton("Wireframe",ButtonGroup1,0);
	QRadioButton *Solid1 = new QRadioButton("Solid",ButtonGroup1,0);
	QRadioButton *Point1 = new QRadioButton("Points",ButtonGroup1,0);
	QObject::connect(ButtonGroup1,SIGNAL(clicked(int)),lab1_gl,SLOT(setRendermodeFront(int)));
	ButtonGroup1->setButton(1);
	
	QButtonGroup *ButtonGroup2 = new QButtonGroup(3,Vertical,"Backface Mode:",RendermodeBox,0);
	QRadioButton *Wireframe2 = new QRadioButton("Wireframe",ButtonGroup2,0);
	QRadioButton *Solid2 = new QRadioButton("Solid",ButtonGroup2,0);
	QRadioButton *Point2 = new QRadioButton("Points",ButtonGroup2,0);
	QObject::connect(ButtonGroup2,SIGNAL(clicked(int)),lab1_gl,SLOT(setRendermodeBack(int)));
	ButtonGroup2->setButton(1);

	QButtonGroup *ButtonGroup3 = new QButtonGroup(2,Vertical,"Shade Model:",Controls,0);
	QRadioButton *Flat = new QRadioButton("Flat",ButtonGroup3,0);
	QRadioButton *Smooth = new QRadioButton("Smooth",ButtonGroup3,0);
	QObject::connect(ButtonGroup3,SIGNAL(clicked(int)),lab1_gl,SLOT(setShadeModel(int)));
	ButtonGroup3->setButton(1);

	Controls->setFixedWidth(Controls->width());
}