#ifndef ALGORITHM_H_INCLUDED
#define ALGORITHM_H_INCLUDED

/*
 * Description: A STL-like for_each function.
 * Pre: begin < end.
 * Post: All elements between begin and end (but not end) are
 * processed by the function func.
 */
#define for_each(begin, end, func) \
do { \
  typeof(begin) itr = begin; \
  for (; itr < end; ++itr) \
    *itr = func(*itr); \
} while (0);

#endif
