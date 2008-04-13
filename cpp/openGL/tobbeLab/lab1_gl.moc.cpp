/****************************************************************************
** lab1_gl_c meta object code from reading C++ file 'lab1_gl.h'
**
** Created: Thu Apr 11 13:57:22 2002
**      by: The Qt MOC ($Id: qt/src/moc/moc.y   2.3.0   edited 2001-02-20 $)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#if !defined(Q_MOC_OUTPUT_REVISION)
#define Q_MOC_OUTPUT_REVISION 9
#elif Q_MOC_OUTPUT_REVISION != 9
#error "Moc format conflict - please regenerate all moc files"
#endif

#include "lab1_gl.h"
#include <qmetaobject.h>
#include <qapplication.h>



const char *lab1_gl_c::className() const
{
    return "lab1_gl_c";
}

QMetaObject *lab1_gl_c::metaObj = 0;

void lab1_gl_c::initMetaObject()
{
    if ( metaObj )
	return;
    if ( qstrcmp(QGLWidget::className(), "QGLWidget") != 0 )
	badSuperclassWarning("lab1_gl_c","QGLWidget");
    (void) staticMetaObject();
}

#ifndef QT_NO_TRANSLATION

QString lab1_gl_c::tr(const char* s)
{
    return qApp->translate( "lab1_gl_c", s, 0 );
}

QString lab1_gl_c::tr(const char* s, const char * c)
{
    return qApp->translate( "lab1_gl_c", s, c );
}

#endif // QT_NO_TRANSLATION

QMetaObject* lab1_gl_c::staticMetaObject()
{
    if ( metaObj )
	return metaObj;
    (void) QGLWidget::staticMetaObject();
#ifndef QT_NO_PROPERTIES
#endif // QT_NO_PROPERTIES
    typedef void (lab1_gl_c::*m1_t0)();
    typedef void (QObject::*om1_t0)();
    typedef void (lab1_gl_c::*m1_t1)();
    typedef void (QObject::*om1_t1)();
    typedef void (lab1_gl_c::*m1_t2)(int,int);
    typedef void (QObject::*om1_t2)(int,int);
    typedef void (lab1_gl_c::*m1_t3)(int);
    typedef void (QObject::*om1_t3)(int);
    typedef void (lab1_gl_c::*m1_t4)(int);
    typedef void (QObject::*om1_t4)(int);
    typedef void (lab1_gl_c::*m1_t5)(int);
    typedef void (QObject::*om1_t5)(int);
    typedef void (lab1_gl_c::*m1_t6)(int);
    typedef void (QObject::*om1_t6)(int);
    typedef void (lab1_gl_c::*m1_t7)(int);
    typedef void (QObject::*om1_t7)(int);
    typedef void (lab1_gl_c::*m1_t8)(int);
    typedef void (QObject::*om1_t8)(int);
    typedef void (lab1_gl_c::*m1_t9)(int);
    typedef void (QObject::*om1_t9)(int);
    typedef void (lab1_gl_c::*m1_t10)(int);
    typedef void (QObject::*om1_t10)(int);
    typedef void (lab1_gl_c::*m1_t11)(int);
    typedef void (QObject::*om1_t11)(int);
    typedef void (lab1_gl_c::*m1_t12)(int);
    typedef void (QObject::*om1_t12)(int);
    m1_t0 v1_0 = &lab1_gl_c::initializeGL;
    om1_t0 ov1_0 = (om1_t0)v1_0;
    m1_t1 v1_1 = &lab1_gl_c::paintGL;
    om1_t1 ov1_1 = (om1_t1)v1_1;
    m1_t2 v1_2 = &lab1_gl_c::resizeGL;
    om1_t2 ov1_2 = (om1_t2)v1_2;
    m1_t3 v1_3 = &lab1_gl_c::setRendermodeFront;
    om1_t3 ov1_3 = (om1_t3)v1_3;
    m1_t4 v1_4 = &lab1_gl_c::setRendermodeBack;
    om1_t4 ov1_4 = (om1_t4)v1_4;
    m1_t5 v1_5 = &lab1_gl_c::setShadeModel;
    om1_t5 ov1_5 = (om1_t5)v1_5;
    m1_t6 v1_6 = &lab1_gl_c::setPeaksX;
    om1_t6 ov1_6 = (om1_t6)v1_6;
    m1_t7 v1_7 = &lab1_gl_c::setPeaksY;
    om1_t7 ov1_7 = (om1_t7)v1_7;
    m1_t8 v1_8 = &lab1_gl_c::setStepsX;
    om1_t8 ov1_8 = (om1_t8)v1_8;
    m1_t9 v1_9 = &lab1_gl_c::setStepsY;
    om1_t9 ov1_9 = (om1_t9)v1_9;
    m1_t10 v1_10 = &lab1_gl_c::setRotX;
    om1_t10 ov1_10 = (om1_t10)v1_10;
    m1_t11 v1_11 = &lab1_gl_c::setRotY;
    om1_t11 ov1_11 = (om1_t11)v1_11;
    m1_t12 v1_12 = &lab1_gl_c::setRotZ;
    om1_t12 ov1_12 = (om1_t12)v1_12;
    QMetaData *slot_tbl = QMetaObject::new_metadata(13);
    QMetaData::Access *slot_tbl_access = QMetaObject::new_metaaccess(13);
    slot_tbl[0].name = "initializeGL()";
    slot_tbl[0].ptr = (QMember)ov1_0;
    slot_tbl_access[0] = QMetaData::Public;
    slot_tbl[1].name = "paintGL()";
    slot_tbl[1].ptr = (QMember)ov1_1;
    slot_tbl_access[1] = QMetaData::Public;
    slot_tbl[2].name = "resizeGL(int,int)";
    slot_tbl[2].ptr = (QMember)ov1_2;
    slot_tbl_access[2] = QMetaData::Public;
    slot_tbl[3].name = "setRendermodeFront(int)";
    slot_tbl[3].ptr = (QMember)ov1_3;
    slot_tbl_access[3] = QMetaData::Public;
    slot_tbl[4].name = "setRendermodeBack(int)";
    slot_tbl[4].ptr = (QMember)ov1_4;
    slot_tbl_access[4] = QMetaData::Public;
    slot_tbl[5].name = "setShadeModel(int)";
    slot_tbl[5].ptr = (QMember)ov1_5;
    slot_tbl_access[5] = QMetaData::Public;
    slot_tbl[6].name = "setPeaksX(int)";
    slot_tbl[6].ptr = (QMember)ov1_6;
    slot_tbl_access[6] = QMetaData::Public;
    slot_tbl[7].name = "setPeaksY(int)";
    slot_tbl[7].ptr = (QMember)ov1_7;
    slot_tbl_access[7] = QMetaData::Public;
    slot_tbl[8].name = "setStepsX(int)";
    slot_tbl[8].ptr = (QMember)ov1_8;
    slot_tbl_access[8] = QMetaData::Public;
    slot_tbl[9].name = "setStepsY(int)";
    slot_tbl[9].ptr = (QMember)ov1_9;
    slot_tbl_access[9] = QMetaData::Public;
    slot_tbl[10].name = "setRotX(int)";
    slot_tbl[10].ptr = (QMember)ov1_10;
    slot_tbl_access[10] = QMetaData::Public;
    slot_tbl[11].name = "setRotY(int)";
    slot_tbl[11].ptr = (QMember)ov1_11;
    slot_tbl_access[11] = QMetaData::Public;
    slot_tbl[12].name = "setRotZ(int)";
    slot_tbl[12].ptr = (QMember)ov1_12;
    slot_tbl_access[12] = QMetaData::Public;
    metaObj = QMetaObject::new_metaobject(
	"lab1_gl_c", "QGLWidget",
	slot_tbl, 13,
	0, 0,
#ifndef QT_NO_PROPERTIES
	0, 0,
	0, 0,
#endif // QT_NO_PROPERTIES
	0, 0 );
    metaObj->set_slot_access( slot_tbl_access );
#ifndef QT_NO_PROPERTIES
#endif // QT_NO_PROPERTIES
    return metaObj;
}
