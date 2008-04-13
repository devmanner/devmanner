#ifndef _CNCPARSER_H_
#define _CNCPARSER_H_

#include <fstream>
#include <iterator>
#include <string>
#include <vector>
#include <deque>
#include <algorithm>
#include <iostream>

#include "cuttercommand.h"
#include "cutterexceptions.h"
#include "cuttercontroller.h"
#include "csgpainter.h"

/*
 * Class:				CNCParser
 * Authour:			Kristoffer Roupé , Tomas Mannerstedt
 * Date:				2003-04-09
 * Description:	Extracts CutterCommands from CNC file
 * Inheritance:	None
 * Uses:				FileNotFoundExecption	[cutterexceptions.h]
 * Updated:
 */
class CNCParser{
private:
  std::vector<std::vector<std::string> > m_matrix;
  std::deque<CutterCommand *> m_commands;
  std::string m_fileName;
	std::deque<CutterCommand*>::iterator m_currPos;
  
  // Methods used by parseFile
  void readFile();
  void removeComments();
  void relToAbs();
  int extractInt(std::string);
  double extractDouble(std::string);
  Vertex getCoords(std::string, unsigned int, unsigned int);
  CutterTool extractTool(unsigned int, unsigned int);
public:
  CNCParser(std::string file=""): m_matrix(), m_fileName(file){
    if(file != "")
      parseFile(m_fileName);
  }
  ~CNCParser(){
    for(std::deque<CutterCommand *>::iterator itr = m_commands.begin(); itr != m_commands.end(); ++itr)
      delete *itr;
  }
  void parseFile(std::string);

	int executeNext();
	void rewind() {
		m_currPos = m_commands.begin();
		CSGPainter::getInstance().clearList();
	}

	int getCurrentRow() {
		if (m_currPos == m_commands.end())
			return -1;
		return (*m_currPos)->getRow();
	}

  void print();
	std::string getFileName() {
		return m_fileName;
	}
};

#endif
