/****************************************************************************
** $Id: qt/glbox.h   3.1.2   edited Nov 8 10:35 $
**
** Copyright (C) 1992-2000 Trolltech AS.  All rights reserved.
**
** This file is part of an example program for Qt.  This example
** program may be used, distributed and modified without limitation.
**
*****************************************************************************/

/****************************************************************************
**
** This is a simple QGLWidget displaying a box
**
****************************************************************************/

#ifndef GLBOX_H
#define GLBOX_H

#include <qgl.h>


class GLBox : public QGLWidget {
  Q_OBJECT
    
  public:
  
  GLBox( QWidget* , const char* , int, int);
  ~GLBox();
  
  public slots:
  void setXRotation( int degrees );
  void setYRotation( int degrees );
  void setZRotation( int degrees );
  
 protected:
  void initializeGL();
  void paintGL();
  void resizeGL( int w, int h );

  virtual GLuint makeObject();

private:
  GLuint object;
  GLuint m_dlist;
  GLfloat xRot, yRot, zRot, m_scale;
  int m_width, m_hight;
};


#endif // GLBOX_H
