#ifndef GLOBJWIN_H
#define GLOBJWIN_H

#include <qwidget.h>
class GLBox;

class GLObjectWindow : public QWidget {
  Q_OBJECT
public:
  GLObjectWindow( QWidget* parent = 0, const char* name = 0 );

private:
 GLBox* m_glb;
};


#endif // GLOBJWIN_H
