// 
// $Id: mainwindow.hpp,v 1.1 2000/12/15 12:54:48 gyros Exp $
//
// Definition of MainWindow class
//
// Gunnstein Lye <gl@ez.no>
// Created on: <15-Dec-2000 12:55:08 gyros>
//
// Copyright (C) 2001 eZ systems as.  All rights reserved.
// Released under the GNU General Public License (GPL).
//

#ifndef MAINWINDOW_HPP
#define MAINWINDOW_HPP

#include <qmainwindow.h>

class GameWidget;


class MainWindow : public QMainWindow
{
public:
    MainWindow( int msec, QWidget *parent, const char *name = 0, WFlags f = 0 );
    virtual ~MainWindow();

private:
    GameWidget *gw;

};


#endif // MAINWINDOW_HPP
