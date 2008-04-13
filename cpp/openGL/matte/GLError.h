#ifndef _GL_ERROR_H_
#define _GL_ERROR_H_

#include <string>

class GLError {
 private:
  GLError() {}
 public:
  static GLError& get_instance() {
    static GLError e;
    return e;
  }
  void print(std::string s="") {
    switch (glGetError()) {
    case GL_INVALID_ENUM:
      printf("%s GLError::print()\nGL_INVALID_ENUM:\nAn unacceptable value is specified  for an enumerated argument. The offending command is ignored, and has no other side effect than to set the error flag.\n", s.c_str());
      break;
    case GL_INVALID_VALUE:
      printf("%s GLError::print()\nGL_INVALID_VALUE\nA numeric argument is out of range. The offending command  is ignored, and has no other side effect than to set the error flag.\n", s.c_str());
      break;
      
    case GL_INVALID_OPERATION:
      printf("%s GLError::print()\nGL_INVALID_OPERATION:\nThe  specified operation is not allowed in  the current state. The offending command is ignored, and has no other side effect than to set the error flag.\n", s.c_str());
      break;
      
    case GL_STACK_OVERFLOW:
      printf("%s GLError::print()\nGL_STACK_OVERFLOW\nThis command would cause a stack overflow. The offending command is ignored, and has no other side effect than to set the error flag.\n", s.c_str());
      break;
      
    case GL_STACK_UNDERFLOW:
      printf("%s GLError::print()\nGL_STACK_UNDERFLOW\nThis  command  would cause a stack underflow. The offending command is ignored, and has no other side effect than to set the error flag.\n", s.c_str());
      break;
      
    case GL_OUT_OF_MEMORY :
      printf("%s GLError::print()\nGL_OUT_OF_MEMORY\nThere is not enough memory left to execute the command. The state of the GL is undefined, except for the stateof the error flags, after this error is recorded.\n", s.c_str());
      break;
    case GL_TABLE_TOO_LARGE:
      printf("%s GLError::print()\nGL_TABLE_TOO_LARGE\nThe specified table exceeds the implementation's maximum supported table size. The offending command is ignored, and has no other side effect than to set the error flag.\n", s.c_str());
      break;
    case GL_NO_ERROR:
    default:
      break;
    }
  }
};
  

#endif
