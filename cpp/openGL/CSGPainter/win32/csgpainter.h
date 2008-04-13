#ifndef _CSGPAINTER_H_
#define _CSGPAINTER_H_

#include <memory.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <vector>
using std::vector;

#include "shape.h"

/*
 * #define the following symbol if you know your glClear honors the
 * stencil mask.  The O2 workstation stencil clear doesn't appear
 * to honor the mask, so we use a workaround.  The workaround may work
 * on any other OpenGL which has this clear bug.
 */
#undef CLEAR_HONORS_STENCIL_MASK

typedef enum {CONTINUE, STOP} progressEnum;

/*
 * Class:				CSGPainter
 * Authour:			Kristoffer Roupé, Tomas Mannerstedt
 * Date:				2003-04-18
 * Description:	Singelton that makes the painting. 
								Can toggle Transparency on/off, CSG on/off
 * Inheritance:	None
 * Updated:
 */
class CSGPainter {
private:
	bool	m_magicTranspHack;
	int		m_whereToStop;
	bool	m_showSurfaces;
	int		m_curPrim;
	int		m_whereSoFar;
	vector<Shape *>	m_prims;
	int		m_stenSize;

	transformation *m_curXform;
	transformation m_globalXform;
	
	CSGPainter() : m_magicTranspHack(false), m_whereToStop(-1), m_showSurfaces(true), m_curPrim(0) {
		m_globalXform.translation[0] = m_globalXform.translation[1] = m_globalXform.translation[2] = 0;
		m_globalXform.rotation[0] = 1;
		m_globalXform.rotation[1] = m_globalXform.rotation[2] = m_globalXform.rotation[3] = 0; 
		m_globalXform.scale[0] = m_globalXform.scale[1] = m_globalXform.scale[2] = 1;
	    glGetIntegerv(GL_STENCIL_BITS, &m_stenSize);
	}

public:
	static CSGPainter &getInstance(){
		static CSGPainter s;
		return s;
	}
	~CSGPainter() {
		for (unsigned int i = 0; i < m_prims.size(); ++i)
			delete m_prims[i];
	}
	void add(Shape *s) {
		if (m_prims.size() == 0)
			m_curXform = s->getTrans();
		m_prims.push_back(s);
	}
	// Clear the list if rewind to from beginning.
	void clearList() {
		for (unsigned int i = 0; i < m_prims.size(); ++i)
			delete m_prims[i];
		m_prims.clear();
	}
	bool curIsGlobal() {
		return m_curXform == &m_globalXform;
	}
	unsigned int numPrims() {
		return m_prims.size();
	}
	void setCurXForm(transformation *t) {
		m_curXform = t;
	}
	transformation* getCurXForm() {
		return m_curXform;
	}
	void setGlobXForm(transformation *t) {
		m_globalXform = *t;
	}
	transformation* getGlobXForm() {
		return &m_globalXform;
	}
	transformation *getPrimXform(int prim){
		return m_prims[prim]->getTrans();
	}
	void setCurPrim(int p) {
		m_curPrim = p;
	}
	int getCurPrim() {
		return m_curPrim;
	}

	void drawXform(transformation *xform, int applyScale);
	void drawPrim(int i);
	void pushOrthoView(float left, float right, float bottom, float top, float znear, float zfar);
	void popView();
	void drawFarRect();
	progressEnum renderPrimDepths(int targetPrim, int frontFace);
	progressEnum trimWithPrimitive(int trimPrim, int isComplemented);
	progressEnum markProductPixels(unsigned int product, int accumBit);
	progressEnum drawProduct(int product, int accumBit);
	void redrawCSG();
	void redrawNoCSG();
	bool toggleSurfaces(){
		m_showSurfaces = !m_showSurfaces;
		return m_showSurfaces;
	}
};

#endif

