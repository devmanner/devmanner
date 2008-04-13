#ifndef _DLList_H_
#define _DLList_H_

#include <iostream>
using namespace std;


template <class T>
class DLList {
 private:
  template <class TT>
  struct Node {
    TT payload;
    Node<TT> *next;
    Node<TT> *prev;

    Node(TT x) : payload(x) {}
  };

  Node<T> *head, *tail;
  unsigned int lsize;

  void remove(Node<T> *x) {
    x->next->prev = x->prev;
    x->prev->next = x->next->prev;
    --lsize;
  }

  void insertAfter(Node<T> *n, Node<T> *after) {
    if (after == 0) { // he's the dummy...
      
    }
    n->next = after->next;
    n->next->prev = n;
    after->next = n;
    n->prev = after;
  }

 public:
  DLList() : head(0), tail(0), lsize(0) { }
  ~DLList() {
    while(lsize)
      ;//remove(head);
  }

  void add(T x) {
    Node<T> *n = new Node<T>(x);
    insertAfter(n, head);
    ++lsize;
  }

  unsigned int size() {
    return lsize;
  }

  void print() {
    for (Node<T> *itr = head; itr != head; itr = itr->next)
      cout << itr->payload << endl;
  }

};


#endif
