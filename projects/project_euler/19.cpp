#include <iostream>

using namespace std;

int DAYS[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
const int WEEKDAYS = 7;
const int MONTHS = 12;

class Day {
  int year, month, day, weekday;

  bool is_leap_year(int year) {
    if (year % 100 == 0)
      return (year % 400) == 0;
    return (year % 4) == 0;
  }
public:
  Day(int y, int m, int d, int wd) : year(y), month(m), day(d), weekday(wd) { }

  void print() const {
    static const char* months[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
    static const char* weekdays[] = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
    cout << year << " " << months[month] << " " << day << " " << weekdays[weekday] << endl;
  }

  void next() {
    weekday = (weekday + 1) % WEEKDAYS;

    day++;
    if (day == DAYS[month]) {
      day = 0;
      month++;
      if (month == MONTHS) {
        month = 0;
        year++;
        if (is_leap_year(year))
          DAYS[1] = 29;
        else
          DAYS[1] = 28;
      }
    }
  }

  int get_year() const { return year; }
  int get_day() const { return day; }
  int get_weekday() const { return weekday; }
};

int main() {
  Day d(1900, 0, 0, 0);
  for (; d.get_year() != 1901; d.next())
    ;
  int days;
  d.print();

  for (days = 0; d.get_year() != 2001; d.next()) {  
    if (d.get_day() == 0 && d.get_weekday() == 6) {
      d.print();
      days++;
    }
  }

  cout << "Days: " << days << endl;

  cout << "not including: ";
  d.print();

  system("PAUSE");
  return 0;
}
