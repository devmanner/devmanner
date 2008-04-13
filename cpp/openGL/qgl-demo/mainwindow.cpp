// 
// $Id: mainwindow.cpp,v 1.1 2000/12/15 12:54:48 gyros Exp $
//
// Implementation of MainWindow class
//
// Gunnstein Lye <gl@ez.no>
// Created on: <15-Dec-2000 12:55:33 gyros>
//
// Copyright (C) 2001 eZ systems as.  All rights reserved.
// Released under the GNU General Public License (GPL).
//


#include "mainwindow.hpp"
#include "gamewidget.hpp"

#include <qapplication.h>
#include <qmenubar.h>
#include <qpopupmenu.h>

/*!
  \class MainWindow mainwindow.hpp
  \brief
  \author <a href="mailto:gl@ez.no">Gunnstein Lye</a>
  \date Enter current date here

*/

/*!
  Default constructor
*/

MainWindow::MainWindow( int msec, QWidget *parent, const char *name, WFlags f )
    : QMainWindow( parent, name, f )
{
    gw =  new GameWidget( this, "GameWidget" );
    setCentralWidget( gw );

    QPopupMenu *fileMenu = new QPopupMenu( 0, "fileMenu" );
    fileMenu->insertItem( tr("&Exit"), qApp, SLOT( quit() ), CTRL+Key_Q );
    menuBar()->insertItem( tr("&File"), fileMenu );

    QPopupMenu *animationMenu = new QPopupMenu( 0, "animationMenu" );
    animationMenu->insertItem( tr("&Stop/Start animation"), centralWidget(),
                               SLOT( toggleAnimate() ), CTRL+Key_S );
    menuBar()->insertItem( tr("&Animation"), animationMenu );

    gw->startTimer( msec );
}

/*!
  Destroys the object
*/

MainWindow::~MainWindow()
{
}

