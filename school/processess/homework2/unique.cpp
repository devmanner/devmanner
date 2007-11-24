/*
 * Compile with:
 * g++ -Wall -o unique unique.cpp -lpthread -lposix4
 * The -lposix4 flag is not needed on linux.
 */

#ifndef _REENTRANT
#define _REENTRANT
#endif

#include "pthread.hpp"

#include <string>
#include <iostream>
#include <iterator>
#include <algorithm>
#include <vector>

#include <cstdio>
#include <cstdlib>
#include <cctype>

/* A global bag of tasks. */
cBagOfTasks<std::string> g_bag;

namespace {
  /* Check if a string contains only unique letters. */
  bool is_unique(const std::string &s) {
    char c[256];
    bzero(c, 256*sizeof(char));
    for (std::string::const_iterator itr = s.begin(); itr != s.end(); ++itr) {
      int tmp = tolower(*itr);
      if (c[tmp])
	return false;
      c[tmp] = 1;
    }
    return true;
  }

  /* Just a function to print a stl-container. */
  template <typename Cont>
  void dump(const Cont &c) {
    std::copy(c.begin(), c.end(), std::ostream_iterator<typename Cont::value_type>(std::cout, " "));
  }
};

/*
 * A class representing the solution of the problem. add_solution() is used
 * to add a all solutions from a worker.
 */
class cSolution {
private:
  std::vector<std::string> m_words;
  std::vector<int> m_workerCnt;
  cMutex m_mutex;
public:
  cSolution(int nworkers) : m_words(), m_workerCnt(nworkers), m_mutex() {}

  void add_solution(std::vector<std::string> &words, int worker) {
    cAutolock a(m_mutex);
    m_workerCnt[worker] = words.size();
    std::copy(words.begin(), words.end(), std::back_inserter(m_words));
  }
  void print() {
    cAutolock a(m_mutex);
    unsigned int maxlen = m_words[0].length();
    std::vector<std::string> longest;
    longest.push_back(m_words[0]);

    /* Find the longest words. */
    for (unsigned int i = 1; i < m_words.size(); ++i) {
      if (m_words[i].length() > maxlen) {
	maxlen = m_words[i].length();
	longest.clear();
	longest.push_back(m_words[i]);
      }
      else if (m_words[i].length() == maxlen) {
	longest.push_back(m_words[i]);
      }
    }
    printf("\nThe %d longest of the %d solutions are:\n", longest.size(), m_words.size());
    dump(longest);
    printf("\n");
    for (unsigned int i = 0; i < m_workerCnt.size(); ++i) {
      printf("Worker %d found %d unique words.\n", i, m_workerCnt[i]);
    }
    printf("\n");
  }
};

class cWorker : public aPThread {
private:
  cSolution *m_psolution;
  std::vector<std::string> m_solution;
  int m_id;

public:
  cWorker(int id, cSolution *s) : aPThread(100), m_psolution(s), m_solution(), m_id(id) {
    printf("Worker %d started to work\n", m_id);
  }
  ~cWorker() {
    printf("Worker %d died\n", m_id);
  }
  
  void run() {
    std::string str;
    std::string::iterator fitr, bitr;
    int status = g_bag.get_task(str);
    /* Did we get a job? */
    if (status == 1) {
      if (is_unique(str)) {
	m_solution.push_back(str);
      }
    }
    else if (status == -1) {
      /* No jobs left ad there will not be any more jobs. */
      m_psolution->add_solution(m_solution, m_id);
      m_bkilled = true;
    }
    else /* No job right now... */
      return;
  }
};

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("Usage: %s number_of_workers\n", argv[0]);
    return 0;
  }

  /* Spawn some workers. */
  int n_workers = atoi(argv[1]);
  cSolution solution(n_workers);
  std::vector<cWorker*> workers;
  
  for (int i = 0; i < n_workers; ++i) {
    workers.push_back(new cWorker(i, &solution));
    workers.back()->spawn();
  }

  /* Read some input and start putting it in the bag of tasks. */
  char buff[128];
  while (scanf("%s", buff) != EOF) {
    g_bag.add_task(buff);
  }  
  g_bag.end();

  /* Wait for workers to be done. */
  for (int i = 0; i < n_workers; ++i) {
    workers[i]->wait();
  }
  solution.print();  

  for (int i = 0; i < n_workers; ++i) {
    delete workers[i];
  }
  return 0;
}
