#include <iostream>
#include <vector>

double median(std::vector<double> v) {
  std::vector<double>::size_type size = v.size();
  if (size == 0)
    throw "ERROR";
  std::sort(v.begin(), v.end());

  std::vector<double>::size_type mid = size / 2;

  if ((size % 2) == 0)
    return (v[mid] + v[mid-1]) / 2.0;
  else
    return v[mid];
}

int main() {
  std::vector<double> v;

  v.push_back(1);
  v.push_back(2);
  v.push_back(3);

  std::cout << median(v) << std::endl;

  v.push_back(4);
  std::cout << median(v) << std::endl;

  system("PAUSE");

  return 0;
}
