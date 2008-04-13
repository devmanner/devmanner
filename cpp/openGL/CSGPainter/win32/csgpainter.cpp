#include "csgpainter.h"

void CSGPainter::drawXform(transformation *xform, int applyScale){
	glTranslatef(xform->translation[0], xform->translation[1], xform->translation[2]);
    glRotatef(xform->rotation[3] / M_PI * 180, xform->rotation[0], xform->rotation[1], xform->rotation[2]);
    if(applyScale)
	glScalef(xform->scale[0], xform->scale[1], xform->scale[2]);
}

void CSGPainter::drawPrim(int i){
	Shape *p = m_prims[i];
    transformation *xform = p->getTrans();

    if(m_magicTranspHack){
        float *c = p->getColor();
		c[3] = .25;
		glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, c);
    }
    else
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, p->getColor());

    glPushMatrix();
    drawXform(xform, true);
    p->draw();
    glPopMatrix();
}

void CSGPainter::pushOrthoView(float left, float right, float bottom, float top,
    float znear, float zfar){
    glPushMatrix();
    glLoadIdentity();
    glMatrixMode(GL_PROJECTION);
    glPushMatrix();
    glLoadIdentity();
    glOrtho(left, right, bottom, top, znear, zfar);
}

void CSGPainter::popView(void){
	glPopMatrix();
    glMatrixMode(GL_MODELVIEW);
    glPopMatrix();
}


void CSGPainter::redrawNoCSG(){
    glDisable(GL_STENCIL_TEST);
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);
    glEnable(GL_CULL_FACE);
    glCullFace(GL_BACK);
    glDepthMask(GL_TRUE);
    glColorMask(GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glPushMatrix();
    drawXform(&m_globalXform, false);

    for(unsigned int i = 0; i < m_prims.size(); i++)
	    drawPrim(i);

    glPopMatrix();
}

void CSGPainter::drawFarRect(void){
    pushOrthoView(0, 1, 0, 1, 0, 1);

    /* Can I just draw & let be clipped? */
    glBegin(GL_QUADS);
    glVertex3f(0, 0, -1);
    glVertex3f(1, 0, -1);
    glVertex3f(1, 1, -1);
    glVertex3f(0, 1, -1);
    glEnd();

    popView();
}


progressEnum CSGPainter::renderPrimDepths(int targetPrim, int frontFace){
    glClear(GL_DEPTH_BUFFER_BIT);
    glDepthFunc(GL_ALWAYS);
    glColorMask(GL_FALSE, GL_FALSE, GL_FALSE, GL_FALSE);
    glStencilMask(0x01);

#ifndef CLEAR_HONORS_STENCIL_MASK /* see comment at beginning of source */

    glDisable(GL_CULL_FACE);
    glDisable(GL_DEPTH_TEST);
    glDepthMask(GL_FALSE);

    glStencilFunc(GL_ALWAYS, 0, 0);
    glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);
    drawFarRect();

	if(m_whereSoFar++ == m_whereToStop)
	    return(STOP);  

#else

    glClearStencil(0);
    glClear(GL_STENCIL_BUFFER_BIT);

#endif

    glEnable(GL_CULL_FACE);
    if(frontFace)
        glCullFace(GL_BACK);
    else
        glCullFace(GL_FRONT);

    glEnable(GL_DEPTH_TEST);
    glDepthMask(GL_TRUE);

    glStencilFunc(GL_EQUAL, 0, 0x01);
    glStencilOp(GL_INCR, GL_INCR, GL_INCR);

    drawPrim(targetPrim);

    return(CONTINUE);
}


progressEnum CSGPainter::trimWithPrimitive(int trimPrim, int isComplemented){
    glDepthFunc(GL_LESS);
    glEnable(GL_STENCIL_TEST);
    glDepthMask(GL_FALSE);
    glColorMask(GL_FALSE, GL_FALSE, GL_FALSE, GL_FALSE);
    glStencilMask(1);
    glDisable(GL_CULL_FACE);

#ifndef CLEAR_HONORS_STENCIL_MASK /* see comment at beginning of source */

    glDisable(GL_DEPTH_TEST);

    glStencilFunc(GL_ALWAYS, !!isComplemented, 0);
    glStencilOp(GL_KEEP, GL_KEEP, GL_REPLACE);
    drawFarRect();

#else

    glClearStencil(!!isComplemented);
    glClear(GL_STENCIL_BUFFER_BIT);

#endif

    glEnable(GL_DEPTH_TEST);
    glStencilFunc(GL_ALWAYS, 0, 0);
    glStencilOp(GL_KEEP, GL_KEEP, GL_INVERT);
    drawPrim(trimPrim);

	if(m_whereSoFar++ == m_whereToStop)
	    return(STOP);  

    /* stencil == 0 where pixels were not inside */
    /* so now set Z to far where stencil == 0, everywhere pixels trimmed */

    glStencilFunc(GL_EQUAL, 0, 1);
    glStencilOp(GL_KEEP, GL_KEEP, GL_KEEP);
    glDepthMask(1);
    glDepthFunc(GL_ALWAYS);
    glDisable(GL_LIGHTING);
    drawFarRect();
    glEnable(GL_LIGHTING);

	if(m_whereSoFar++ == m_whereToStop)
	    return(STOP);  

    return(CONTINUE);
}


progressEnum CSGPainter::markProductPixels(unsigned int product, int accumBit){
    if(renderPrimDepths(product, m_prims[product]->isPiece()) == STOP)
        return(STOP);

	if(m_whereSoFar++ == m_whereToStop)
	    return(STOP);  

    for(unsigned int i = 0; i < m_prims.size(); i++){
		if (i != product) {
			if (m_prims[product]->isPiece()){
				if(trimWithPrimitive(i, 1) == STOP)
					return(STOP);
			}
			else
				if(trimWithPrimitive(i, !m_prims[i]->isPiece()) == STOP)
					return(STOP);				
		}
	}

 	if(m_whereSoFar++ == m_whereToStop)
	    return(STOP);  
    /* set accumulator stencil bit for this primitive everywhere depth != far */
    glStencilFunc(GL_ALWAYS, 1 << accumBit, 0);
    glStencilOp(GL_KEEP, GL_ZERO, GL_REPLACE);
    glStencilMask(1 << accumBit);
    glDepthMask(0);
    glDepthFunc(GL_GREATER);
    glDisable(GL_LIGHTING);
    drawFarRect();
    glEnable(GL_LIGHTING);

    //COPY_AND_RETURN_IF_DONE("After setting accumulator where depths != far");
	if(m_whereSoFar++ == m_whereToStop)
	    return(STOP);  
    return(CONTINUE);
}

progressEnum CSGPainter::drawProduct(int product, int accumBit){
    glEnable(GL_CULL_FACE);
    if(m_prims[product]->isPiece())
        glCullFace(GL_BACK);
    else
        glCullFace(GL_FRONT);

    glDepthMask(GL_TRUE);
    glColorMask(GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE);
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);
    glEnable(GL_STENCIL_TEST);
    glStencilFunc(GL_EQUAL, 1 << accumBit, 1 << accumBit);
    glStencilOp(GL_KEEP, GL_KEEP, GL_KEEP);
    drawPrim(product);

    //COPY_AND_RETURN_IF_DONE("After drawing target color and depth");
	if(m_whereSoFar++ == m_whereToStop)
	    return(STOP);  
    return(CONTINUE);
}

void CSGPainter::redrawCSG(void){
    unsigned int i;
    int accumBit;
    unsigned int firstProduct;
    unsigned int lastProduct;

    m_whereSoFar = 0;
    glDepthMask(GL_TRUE);
    glColorMask(GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE); 
    glClear(GL_COLOR_BUFFER_BIT);

    /* Only have to do this if you're going to look at the stencil buffer */
    glClearStencil(0);
    glStencilMask((1 << m_stenSize) - 1);
    glClear(GL_STENCIL_BUFFER_BIT);

    glPushMatrix();

    drawXform(&m_globalXform, false);

    firstProduct = 0;

    while(firstProduct != m_prims.size()) {
    
 		/*
		 * set lastProduct so that accum bits for first to last fit in
		 * stencil buffer minus bits needed for surface counting bits
		 */
		lastProduct = firstProduct + (m_stenSize - 1) - 1;
		if(lastProduct >= m_prims.size())
			lastProduct = m_prims.size() - 1;

		accumBit = 1;		/* first available after counting bits */

		for(i = firstProduct; i <= lastProduct; i++)
			if(markProductPixels(i, accumBit++) == STOP){
				glPopMatrix();
				//glutSwapBuffers();
				return;
			}

		if(m_whereSoFar++ == m_whereToStop) { 
			glPopMatrix();
			//glutSwapBuffers();
			return;
		}

		glDepthMask(GL_TRUE);
		glClear(GL_DEPTH_BUFFER_BIT);

		accumBit = 1;		/* first available after counting bits */
		
		for(i = firstProduct; i <= lastProduct; i++)
			if(drawProduct(i, accumBit++) == STOP){
				glPopMatrix();
				//glutSwapBuffers();
				return;
			}
		

		if(m_whereSoFar++ == m_whereToStop) { 
			glPopMatrix();
			//glutSwapBuffers();
			return;
		}
			
		firstProduct = lastProduct + 1;
    }

    if(m_showSurfaces) {
		glDisable(GL_STENCIL_TEST);
		glDepthMask(GL_FALSE);
		glEnable(GL_CULL_FACE);
		glCullFace(GL_BACK);
		glEnable(GL_BLEND);
		m_magicTranspHack = 1;
		for(i = 0; i < m_prims.size(); i++)
			drawPrim(i);
		
		m_magicTranspHack = 0;
		glDisable(GL_BLEND);
    }

    glPopMatrix();
}

