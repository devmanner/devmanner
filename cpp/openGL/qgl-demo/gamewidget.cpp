// 
// $Id: gamewidget.cpp,v 1.3 2000/12/15 12:54:48 gyros Exp $
//
// Implementation of GameWidget class
//
// Gunnstein Lye <gl@ez.no>
// Created on: <13-Dec-2000 20:11:51 gyros>
//
// Copyright (C) 2001 eZ systems as.  All rights reserved.
// Released under the GNU General Public License (GPL).
//


#include "gamewidget.hpp"
#include "map.hpp"

#include <qtimer.h>

#include <math.h>


/*!
  \class GameWidget gamewidget.hpp
  \brief
  \author <a href="mailto:gl@ez.no">Gunnstein Lye</a>
  \date Enter current date here

*/

/*!
  Default constructor
*/

GameWidget::GameWidget( QWidget *parent, const char *name )
    : QGLWidget( parent, name ),
    Animate( true ), Angle( 0.0 )
{
    Timer = new QTimer( this, "Timer" );
    connect( Timer, SIGNAL( timeout() ), SLOT( updateGL() ) );
}

/*!
  Destroys the object
*/

GameWidget::~GameWidget()
{
    glDeleteLists( Landscape, 1 );
}

/*!
  Starts the times used for rotation, when it has been paused.
 */

void GameWidget::startTimer( int msec )
{
    Timer->start( msec, false );
}

/*!
  Set up lighting and display list.
*/

void GameWidget::initializeGL()
{
    // lighting settings
    static GLfloat pos[4] = { 5.0, 5.0, 5.0, 1.0 };
    glLightfv( GL_LIGHT0, GL_POSITION, pos );
    glEnable( GL_CULL_FACE );
    glEnable( GL_LIGHTING );
    glEnable( GL_LIGHT0 );
    glEnable( GL_DEPTH_TEST );

    static GLfloat ared[4] = { 0.8, 0.1, 0.0, 1.0 };
    Landscape = glGenLists(1);     // start building a display list
    glNewList( Landscape, GL_COMPILE );
    glMaterialfv( GL_FRONT, GL_AMBIENT_AND_DIFFUSE, ared );
    buildLandscape();
    glEndList();                   // done with display list

    glEnable( GL_NORMALIZE );
}

/*!
  Set up viewport, at the beginning and when the size of the window changes.
*/

void GameWidget::resizeGL( int width, int height )
{
    GLfloat w = (float) width / (float) height;
    GLfloat h = 1.0;

    glViewport( 0, 0, width, height );
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glFrustum( -w, w, -h, h, 5.0, 60.0 );
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glTranslatef( 0.0, 0.0, -40.0 );
}

/*!
  Rotate and repaint the scene.
*/

void GameWidget::paintGL()
{
    if ( Animate )
        Angle += 2.0;

    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

    glPushMatrix();
    glTranslatef( 0.0, -5.0, 0.0 );
    glRotatef( Angle, 0.0, 1.0, 0.0 );
    glCallList( Landscape );             // call display list
    glPopMatrix();
}

/*!
  Start or stop the rotation.
*/

void GameWidget::toggleAnimate()
{
    if ( Animate )
        Animate = false;
    else
        Animate = true;
}

/*!
  Vector cross product, given 3 vertices
*/

GameWidget::vector GameWidget::xp( GameWidget::vector a, GameWidget::vector b, GameWidget::vector c )
{
    GameWidget::vector m, n, p;

    m.x = b.x - a.x;  n.x = c.x - a.x;
    m.y = b.y - a.y;  n.y = c.y - a.y;
    m.z = b.z - a.z;  n.z = c.z - a.z;

    p.x = m.y*n.z - m.z*n.y;
    p.y = m.z*n.x - m.x*n.z;
    p.z = m.x*n.y - m.y*n.x;

    return p;
}

/*!
  Reads the heigh field and does the actual rendering
*/

void GameWidget::buildLandscape()
{
    int wd = WIDTH/2;
    int hd = HEIGHT/2;
    int a, b, c, d;
    GameWidget::vector va, vb, vc, vp;
    glShadeModel( GL_SMOOTH );

    for ( int w = 0; w < WIDTH-1; w++ )
    {
        for ( int h = 0; h < HEIGHT-1; h++ )
        {
            a = hm[w][h];
            b = hm[w][h+1];
            c = hm[w+1][h];
            d = hm[w+1][h+1];

            // the square does not need to be split into triangles
            if ( ( a == b && c == d ) || ( a == c && b == d ) )
            {
                glBegin( GL_QUADS );

                va.x = w;    va.y = a;  va.z = h;
                vb.x = w;    vb.y = b;  vb.z = h+1;
                vc.x = w+1;  vc.y = c;  vc.z = h;
                vp = xp( va, vb, vc );
                glNormal3f( vp.x, vp.y, vp.z );
                glTexCoord2f( 0.005f, 0.005f );  glVertex3f( w - wd,   a, h - hd );
                glTexCoord2f( 0.995f, 0.005f );  glVertex3f( w - wd,   b, h+1 - hd );
                glTexCoord2f( 0.995f, 0.995f );  glVertex3f( w+1 - wd, d, h+1 - hd );
                glTexCoord2f( 0.005f, 0.995f );  glVertex3f( w+1 - wd, c, h - hd );

                glEnd();
            }

            // the square should be split
            else
            {
                // two cases, for the two possible diagonals.

                if ( dm[w][h] )
                {
                    glBegin( GL_TRIANGLES );

                    va.x = w;    va.y = a;  va.z = h;
                    vb.x = w;    vb.y = b;  vb.z = h+1;
                    vc.x = w+1;  vc.y = c;  vc.z = h;
                    vp = xp( va, vb, vc );
                    glNormal3f( vp.x, vp.y, vp.z );
                    glTexCoord2f( 0.005f, 0.005f );  glVertex3f( w - wd,   a, h - hd );
                    glTexCoord2f( 0.995f, 0.005f );  glVertex3f( w - wd,   b, h+1 - hd );
                    glTexCoord2f( 0.995f, 0.995f );  glVertex3f( w+1 - wd, c, h - hd );

                    va.x = w;    va.y = b;  va.z = h+1;
                    vb.x = w+1;  vb.y = d;  vb.z = h+1;
                    vc.x = w+1;  vc.y = c;  vc.z = h;
                    vp = xp( va, vb, vc );
                    glNormal3f( vp.x, vp.y, vp.z );
                    glTexCoord2f( 0.005f, 0.005f );  glVertex3f( w - wd,   b, h+1 - hd );
                    glTexCoord2f( 0.995f, 0.005f );  glVertex3f( w+1 - wd, d, h+1 - hd );
                    glTexCoord2f( 0.995f, 0.995f );  glVertex3f( w+1 - wd, c, h - hd );

                    glEnd();
                }
                else
                {
                    glBegin( GL_TRIANGLES );

                    va.x = w;    va.y = a;  va.z = h;
                    vb.x = w;    vb.y = b;  vb.z = h+1;
                    vc.x = w+1;  vc.y = d;  vc.z = h+1;
                    vp = xp( va, vb, vc );
                    glNormal3f( vp.x, vp.y, vp.z );
                    glTexCoord2f( 0.005f, 0.005f );  glVertex3f( w - wd,   b, h+1 - hd );
                    glTexCoord2f( 0.995f, 0.005f );  glVertex3f( w+1 - wd, d, h+1 - hd );
                    glTexCoord2f( 0.995f, 0.995f );  glVertex3f( w - wd,   a, h - hd );

                    va.x = w;    va.y = a;  va.z = h;
                    vb.x = w+1;  vb.y = d;  vb.z = h+1;
                    vc.x = w+1;  vc.y = c;  vc.z = h;
                    vp = xp( va, vb, vc );
                    glNormal3f( vp.x, vp.y, vp.z );
                    glTexCoord2f( 0.005f, 0.005f );  glVertex3f( w - wd,   a, h - hd );
                    glTexCoord2f( 0.995f, 0.005f );  glVertex3f( w+1 - wd, d, h+1 - hd );
                    glTexCoord2f( 0.995f, 0.995f );  glVertex3f( w+1 - wd, c, h - hd );

                    glEnd();
                }
            }
        }
    }
}

