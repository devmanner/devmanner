#include <stdlib.h>
#include "cncparser.h"

using std::string;
using std::ifstream;
using std::istream_iterator;
using std::ostream_iterator;
using std::back_inserter;
using std::copy;
using std::getline;
using std::vector;

void CNCParser::parseFile(string file){
  if (m_fileName == "")
    m_fileName = file;
  readFile();
  removeComments();
  relToAbs();

  // Parse Commands
  // Some state variables...
  bool nextTDisable = false;
  for(unsigned int row=0; row < m_matrix.size();++row){
    for(unsigned int col=0; col < m_matrix[row].size(); ++col){
      switch((m_matrix[row][col])[0]){
      case '%':	/* Set title on window */break;
      case 'F':m_commands.push_back(new ControlUpdateCommand<double>(row,extractDouble(m_matrix[row][col]),&CutterController::setFeed));
	break;
      case 'G':
	switch(extractInt(m_matrix[row][col])){
	case 0:
	case 1:	m_commands.push_back(new LinearMovementCommand(row,getCoords("XYZ", row, col),extractInt(m_matrix[row][col])));
	  break;
	case 2: 
	case 3:	m_commands.push_back(new CircularMovementCommand(row,getCoords("XYZ", row, col),getCoords("IJ_", row, col), (extractInt(m_matrix[row][col]) == 2)));
	  break;
	case 17:
	case 18:
	case 19:m_commands.push_back(new ControlUpdateCommand<int>(row,extractInt(m_matrix[row][col]),&CutterController::setOrientationMode));
	  break;
	case 30:m_commands.push_back(new ControlUpdateCommand<Vertex>(row,getCoords("XYZ", row, col),&CutterController::setMin));
	  break;
	case 31:m_commands.push_back(new ControlUpdateCommand<Vertex>(row,getCoords("XYZ", row, col),&CutterController::setMax));
	  break;
	case 70:m_commands.push_back(new ControlUpdateCommand<bool>(row,true,&CutterController::setInchMode));
	  break;
	case 71:m_commands.push_back(new ControlUpdateCommand<bool>(row,false,&CutterController::setInchMode));
	  break;
	case 99:nextTDisable = true; // Disable to take action on next T
	  m_commands.push_back(new ControlUpdateCommand<CutterTool>(row,extractTool(row, col),&CutterController::defineTool));
	  break;
	}
	break;
    case 'L':	// Lable or tool length.
		break;
    case 'M':	switch(extractInt(m_matrix[row][col])){
					case 0:
					case 2:
					case 30:
					  m_commands.push_back(new ControlUpdateCommand<int>(row,5,&CutterController::setDirection)); // Stop
					  m_commands.push_back(new ControlUpdateCommand<bool>(row,false,&CutterController::setCooling));
					  break;
					case 3:	
					case 4: 
					case 5: m_commands.push_back(new ControlUpdateCommand<int>(row,extractInt(m_matrix[row][col]),&CutterController::setDirection));
					  break;
					case 6:
					  break;
					case 8:
					  m_commands.push_back(new ControlUpdateCommand<bool>(row,true,&CutterController::setCooling));
					  break;
					case 9:
					  m_commands.push_back(new ControlUpdateCommand<bool>(row,false,&CutterController::setCooling));
					  break;
					case 13:
					case 14:
					  m_commands.push_back(new ControlUpdateCommand<int>(row,extractInt(m_matrix[row][col])-10,&CutterController::setDirection)); // Set direction
					  m_commands.push_back(new ControlUpdateCommand<bool>(row,true,&CutterController::setCooling));
					  break;
					default: throw UnknownCNCCommandException(m_matrix[row][col]);
					  break;
					}
		break;
    case 'N':	
	  break;
    case 'R':	
	  break;
    case 'S':	m_commands.push_back(new ControlUpdateCommand<int>(row,extractInt(m_matrix[row][col]),&CutterController::setSpeed));
	  break;
    case 'T':	if (nextTDisable)
					nextTDisable = false;
				else
					m_commands.push_back(new ControlUpdateCommand<int>(row,extractInt(m_matrix[row][col]),&CutterController::setTool));
				break;
    default:	
		break;
      }			
    }
  }

	// Set the currPos iterator to the beginning.
	m_currPos = m_commands.begin();
}

/*
 * Reads a file specifyed by m_fileName to m_matrix. 
 */
void CNCParser::readFile(){
 if(m_fileName != ""){
    string buf;
    ifstream source(m_fileName.c_str());
    istream_iterator<string> pos(source), end;
    if(pos == end)
      throw FileNotFoundException(m_fileName);
    vector<string> tmp;
    while(pos != end){
      string s = *pos;
      s[0] = ::toupper((*pos)[0]);
      if(s[0] == 'N') {
				m_matrix.push_back(tmp);
				tmp.clear();
      }
      tmp.push_back(s);
      ++pos;
    }
    m_matrix.push_back(tmp);
  }
  else
    throw FileNotFoundException(m_fileName);
}

/*
 * Remove comments from m_matrix.
 */
void CNCParser::removeComments(){
  for(std::vector<std::vector<std::string> >::iterator ritr = m_matrix.begin(); ritr != m_matrix.end(); ++ritr){
    for(std::vector<std::string>::iterator citr = (*ritr).begin(); citr != (*ritr).end(); ++citr){
      string::iterator sitr = std::find((*citr).begin(), (*citr).end(),';');
      if(sitr != (*citr).end()){
	// Remove remaining part of the word
	(*citr).erase(sitr, (*citr).end());
	// Remove remaining part of the row.
	(*ritr).erase(++citr, (*ritr).end());
	break;
      }
    }
  }
}


/*
 * Translate relative coordinates in m_matrix to absolute coordinates.
 * Does not remove the G90 and G91 coords. Thease are just ignored
 * in the parsing.
 */
void CNCParser::relToAbs(){
  Vertex cpos(0, 0, 0);
  bool isRel = false;
  char buff[10];
  for(unsigned int row=0; row < m_matrix.size();++row){
    for(unsigned int col=0; col < m_matrix[row].size(); ++col){
      switch((m_matrix[row][col])[0]) {
      case 'G':
	if (m_matrix[row][col] == "G91")
	  isRel = true;
	else if (m_matrix[row][col] == "G90")
	  isRel = false;
	break;
      case 'X':
								cpos.m_x = (isRel) ? cpos.m_x + extractDouble(m_matrix[row][col]) : extractDouble(m_matrix[row][col]);
								sprintf(buff, "X%f", cpos.m_x);
								m_matrix[row][col] = buff;
								break;
      case 'Y':
								cpos.m_y = (isRel) ? cpos.m_y + extractDouble(m_matrix[row][col]) : extractDouble(m_matrix[row][col]);
								sprintf(buff, "Y%f", cpos.m_y);
								m_matrix[row][col] = buff;
								break;
      case 'Z':
								cpos.m_z = (isRel) ? cpos.m_z + extractDouble(m_matrix[row][col]) : extractDouble(m_matrix[row][col]);
								sprintf(buff, "Z%f", cpos.m_z);
								m_matrix[row][col] = buff;
								break;
      default:	break;
      }
    }
  }
}

int CNCParser::extractInt(string token){
  return atoi(&(token.c_str())[1]);
}
double CNCParser::extractDouble(string token){
  return atof(&(token.c_str())[1]);
}

Vertex CNCParser::getCoords(string desc, unsigned int row, unsigned int col) {
  Vertex tmp;
  for (; col < m_matrix[row].size(); ++col) {
    if ((m_matrix[row][col])[0] == desc[0])
      tmp.m_x = extractDouble(m_matrix[row][col]);
    else if ((m_matrix[row][col])[0] == desc[1])
      tmp.m_y = extractDouble(m_matrix[row][col]);
    else if ((m_matrix[row][col])[0] == desc[2])
      tmp.m_z = extractDouble(m_matrix[row][col]);
    else {
      
    }
  }
  return tmp;
}

CutterTool CNCParser::extractTool(unsigned int row, unsigned int col) {
  CutterTool tmp(0, 0, 0);
  for (; col < m_matrix[row].size(); ++col) {
    switch((m_matrix[row][col])[0]) {
    case 'T': tmp.setNo(extractInt(m_matrix[row][col])); break;
    case 'L': tmp.setLength(extractDouble(m_matrix[row][col])); break;
    case 'R': tmp.setRadius(extractDouble(m_matrix[row][col])); break;
    default: break;
    }
  }
  return tmp;
}



void CNCParser::print(){
  ostream_iterator<string> output(cout , " ");
  for(unsigned int i=0; i < m_matrix.size(); ++i){
    copy(m_matrix[i].begin(), m_matrix[i].end(), output);
    cout << "\n";
  }
}

// Return -1 on failure or the last one is executed.
int CNCParser::executeNext() {
	if(m_commands.size() != 0 && m_currPos != m_commands.end()){
		unsigned int currRowNo = (*m_currPos)->getRow();
		while ((*m_currPos)->getRow() == currRowNo) {
			(*m_currPos)->execute();
			++m_currPos;
			printf("Executing from row: %d\n", currRowNo);
			if (m_currPos == m_commands.end())
				return -1;
		}
		return currRowNo;
	}
	else
		return -1;
}
