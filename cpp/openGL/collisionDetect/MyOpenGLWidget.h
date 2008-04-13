#include <list>
#include <qgl.h>
#include "shape.h"

using std::list;

class MyOpenGLWidget : public QGLWidget
{
  Q_OBJECT        // must include this if you use Qt signals/slots
    
public:
  MyOpenGLWidget( int timerDelay=10 /* 100 FPS */, QWidget *parent=0, const char *name=0 );
  ~MyOpenGLWidget() {
    for (list<Shape*>::iterator itr = m_shapes.begin(); itr != m_shapes.end(); ++itr)
      delete (*itr);
}
  
 protected:
  void mousePressEvent ( QMouseEvent * e );
  void keyPressEvent ( QKeyEvent * e );
  void initializeGL();
  void resizeGL( int w, int h );
  void paintGL();
  
 private:
  QTimer *timer;
  GLfloat m_scale;
  GLfloat m_xRot, m_yRot, m_zRot;

  list<Shape *> m_shapes;
};
