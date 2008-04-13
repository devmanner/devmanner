#ifndef _CUTTEREXCEPTIONS_H_
#define _CUTTEREXCEPTIONS_H_

#include <exception>

/*
 * Class:				CutterException
 * Authour:			Kristoffer Roupé, Tomas Mannerstedt
 * Date:				2003-04-05
 * Description:	CutterException baseclass
 * Inheritance:	None
 * Updated:
 */
class CutterException{
private:
  std::string m_message;
 public:
  CutterException(std::string s):m_message(s){}
  virtual ~CutterException(){}
  friend std::ostream &operator<<(std::ostream &out, const CutterException &ce){
    return out << ce.m_message;
  }
  std::string getMessage(){
    return m_message;
  }
};

/*
 * Class:				FileNotFoundException
 * Authour:			Kristoffer Roupé, Tomas Mannerstedt
 * Date:				2003-04-05
 * Description:	To be used if a file is not found
 * Inheritance:	None
 * Updated:
 */
class FileNotFoundException : public CutterException {
 public:
  FileNotFoundException(std::string file=""):
			 CutterException(std::string("FileNotFoundException: ").operator +=(file).operator +=(" not found")){}
};

/*
 * Class:				UnknownCNCCommandException
 * Authour:			Kristoffer Roupé, Tomas Mannerstedt
 * Date:				2003-04-05
 * Description:	To be used if CNCCommand is not understood or found
 * Inheritance:	None
 * Updated:
 */
class UnknownCNCCommandException : public CutterException {
 public:
	 UnknownCNCCommandException(std::string token=""):CutterException(std::string("UnknownCNCCommandException: ").operator +=(token).operator +=(" is unknown.")){}
};


#endif

