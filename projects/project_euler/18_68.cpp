#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>

#define my_assert(X) if (!(X)) { cout << #X << " failed!" << endl; system("PAUSE"); exit(-1); }

using namespace std;

int sum(int n) {
  return (n*(n+1))/2;
}

int pow2(int exp) {
  if (exp == 0)
    return 1;
  int res = 2;
  for (int i = 1; i < exp; ++i)
    res *= 2;
  return res;
}

class Triangle {
  vector<int> data;

public:
  Triangle(const char *fname) : data() {
    std::ifstream fs(fname);
    int i;
    while (fs >> i)
      data.push_back(i);
  }

  int& acc(int row, int col) {
    int index = sum(row) + col;
    my_assert(index >= 0);
    my_assert(index < data.size());
    return data[index];
  }

  int rows() {
    int rows;
    for (rows = 1; sum(rows) + cols(rows)-1 < data.size(); ++rows)
      ;
    return rows;
  }

  int cols(int row) {
    return row+1;
  }

  void print() {
    int cols = 1;
    for (int row = 0; row < rows(); ++row) {
      for (int col = 0; col < cols; ++col) {
        cout << acc(row, col) << " ";
      }
      cout << endl;
      cols += 1;
    }
  }

  int max_trip() {
    cout << "in max_trip" << endl;
    for (int row = rows()-2; row >= 0; --row) {
      for (int col = cols(row)-1; col >= 0; --col) {
        //cout << "(" << row << ", " << col << ")" << endl;
        acc(row, col) += std::max(acc(row+1, col), acc(row+1, col+1));
      }
    }
    return acc(0,0);
  }
};

int main() {
  Triangle t("68.txt");

  t.print();

  cout << "max_trip: " << t.max_trip() << endl;
  //t.print();

  system("PAUSE");
  return 0;
}
