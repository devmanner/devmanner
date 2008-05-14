#include <iostream>
#include <vector>
#include <iterator>
#include <algorithm>

#include <algo.h>

using namespace std;

template <typename Itr>
void do_fast_sort(Itr first, Itr last) {
     do {
           random_shuffle(first, last);
     } while (!is_sorted(first, last));
}

template <typename Itr>
void fast_sort(Itr first, Itr last) {
     do_fast_sort(first, last);
     // Just to make sure it's really sorted!
     do_fast_sort(first, last);
}

void test(int N) {
    cout << "N: " << N << endl;
    std::vector<int> x(N);

    generate(x.begin(), x.end(), rand);

    copy(x.begin(), x.end(), ostream_iterator<int>(cout, " "));
    cout << endl;

    fast_sort(x.begin(), x.end());

    copy(x.begin(), x.end(), ostream_iterator<int>(cout, " "));
    cout << endl << endl;
}

int main() {
    srand(time(NULL));

    for (int i = 1; i < 9; ++i)
        test(i);

    system("PAUSE");
    return 0;
}
