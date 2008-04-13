// 
// $Id: gamewidget.hpp,v 1.3 2000/12/15 12:54:48 gyros Exp $
//
// Definition of GameWidget class
//
// Gunnstein Lye <gl@ez.no>
// Created on: <13-Dec-2000 20:11:27 gyros>
//
// Copyright (C) 2001 eZ systems as.  All rights reserved.
// Released under the GNU General Public License (GPL).
//

#ifndef GAMEWIDGET_HPP
#define GAMEWIDGET_HPP

#include <qgl.h>

class QTimer;


class GameWidget : public QGLWidget
{
    Q_OBJECT
public:
    struct vector { GLfloat x; GLfloat y; GLfloat z; };

    GameWidget( QWidget *parent, const char *name=0 );
    ~GameWidget();

    void startTimer( int msec );

protected slots:
    void toggleAnimate();

protected:
    void initializeGL();
    void resizeGL( int width, int height );
    void paintGL();
    void buildLandscape();
    void buildTexture();
    vector xp( vector a, vector b, vector c );

private:
    QTimer *Timer;
    bool Animate;

    GLfloat Angle;
    GLint Landscape;
    GLuint Texture_ID;

};

#endif // GAMEWIDGET_HPP
