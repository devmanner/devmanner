#ifndef _PAYLOAD_H_
#define _PAYLOAD_H_

typedef int payload_t;
typedef int pos_t;

class Mission {
 private:
  pos_t m_dest;
 public:
  pos_t toWhere() { return m_dest; }
};

class Movement : public Mission {
  
};


class Payload : public Mission {
 private:
  payload_t m_type;
 public:
  Payload(payload_t t=0) : m_type(t) {}
  payload_t getType() { return m_type; }
  
};


/*
class PayloadFactory {
 private:
  static PayloadFactory* m_instance;
  PayloadFactory() {};
 public:
  Payload* createPayload(payload_t t=0) {return new Payload(t);}
  PayloadFactory* getInstance() { return ((m_instance) ? m_instance : m_instance = new PayloadFactory()); }
  void kill() { delete m_instance; }
};
*/

#endif
