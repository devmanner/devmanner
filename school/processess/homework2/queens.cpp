/*
 * Compile with:
 * g++ -Wall -o queens queens.cpp -lpthread -lposix4
 * The -lposix4 is not needed on linux
 */

#ifndef _REENTRANT
#define _REENTRANT
#endif

#include "pthread.hpp"
#include <vector>
#include <cstdio>
#include <cassert>

typedef unsigned long long int board_t;
const board_t ONE = 1;

/* A class representing a chessboard as a 64-bit integer. */
class cBoard {
private:
  board_t m_board;
public:
  cBoard() : m_board(0) { }
  cBoard(const cBoard &b) : m_board(b.m_board) { }
  
  /* row && col are zero-counted. */
  void set(int row, int col) {
    m_board |= (ONE << (row*8 + col));
  }
  int get(int row, int col) {
    return (m_board >> (row*8 + col)) & ONE;
  }
  void print() {
    for (int r = 0; r < 8; ++r) {
      for (int c = 0; c < 8; ++c)
	printf("%c", (get(r, c) ? 'Q' : '+'));
      printf("\n");
    }
  }
  /*
   * This function could be implemented much smarter but I really don't have the time right now...
   * It checks if a queen can be placed on (row, col) without interfering with queens already
   * on the board.
   */
  
  bool ok_add(int row, int col) {
    /* Is there anyone on the same row or column. */
    for (int x = 0; x < 8; ++x)
      if (get(x, col) || get(row, x))
	return false;

    /* Is there anyone on my diagonal? */
    /* \ way */
    for (int r = row, c = col; r < 8 && c < 8; ++r, ++c)
      if (get(r, c))
	return false;
    for (int r = row, c = col; r != -1 && c != -1; --r, --c)
      if (get(r, c))
	return false;
    /* / way */
    for (int r = row, c = col; r != -1 && c < 8; --r, ++c)
      if (get(r, c))
	return false;
    for (int r = row, c = col; r < 8 && c != -1; ++r, --c)
      if (get(r, c))
	return false;
    return true;
  }
};

/*
 * A structure for the solution. Use add() to to add a solution (in this case a board
 * with queens, and print() to print all solutions.
 */
class cSolution {
  std::vector<cBoard> m_boards;
  cMutex m_mutex;
public:
  cSolution() : m_boards(), m_mutex() {}
  void add(cBoard &b) {
    cAutolock a(m_mutex);
    m_boards.push_back(b);
    printf("Adding solution\n");
  }
  void print() {
    cAutolock a(m_mutex);
    printf("The %d solutions are:\n", m_boards.size());
    for (unsigned int i = 0; i < m_boards.size(); ++i) {
      m_boards[i].print();
      printf("\n");
    }
  }
};

/*
 * A worker thread class.
 */
class cWorker : public aPThread {
private:
  cSolution *m_sol;
  cBoard m_board;
  int m_row;
public:
  cWorker(cSolution *s, const cBoard &b, int r) : m_sol(s), m_board(b), m_row(r) {
  }
  ~cWorker() {
  }
  
  void thread_loop() {
    if (m_row == 8) {
      m_sol->add(m_board);
    }
    else {
      /* Vector to hold the children. */
      std::vector<cWorker*> workers;
      for (int col = 0; col < 8; ++col) {
	/* If we can place a queen on the row. */
	if (m_board.ok_add(m_row, col)) {
	  /* Create a worker (child) and spawn it right away. */
	  cBoard tmp(m_board);
	  tmp.set(m_row, col);
	  workers.push_back(new cWorker(m_sol, tmp, m_row+1));
	  workers.back()->spawn();
	}
      }
      /* Wait for and delete children. */
      for (unsigned int i = 0; i < workers.size(); ++i)
	workers[i]->wait();
      for (unsigned int i = 0; i < workers.size(); ++i)
	delete workers[i];
    }
  }
  /* This method has to be overloaded in the current aPThread class implementation... */
  void run() {
  }
};

int main(int argc, char *argv[]) {
  assert(sizeof(board_t) == 8);

  cBoard board;
  cSolution solution;
  /* We start with only one worker. */
  cWorker worker(&solution, board, 0);
  worker.spawn();
  /* And because of recursion we only have to wait for one worker. */
  worker.wait();
  solution.print();  

  return 0;
}
