#include <iostream>
using namespace std;

/* En struct som mappar en anv�ndare mot ett l�senord. */
struct UserPass {
  char user[50];
  char pass[50];
};

/* Antal users. */
#define NO_USERS 2

int main() {
  char user[50];
  char pass[50];
  bool rightPass = false;

  /* En array som inneh�ller ett antal UserPass structar initierade till olika v�rden. */
  UserPass userPasses[] = { {"user1", "pass1"}, {"user2", "pass2"} };
  

  cout << "This is a Jonathan Husell production\n";
  cout << "try login jonathan password fragile\n";

  while(!rightPass) {
    cout << "Login: ";
    cin >> user;
    cout << "Pass: ";
    cin >> pass;
    for (unsigned int i = 0; i < NO_USERS ; ++i) {
      if (!strcmp(user, userPasses[i].user) &&
	  !strcmp(pass, userPasses[i].pass) ) 
	rightPass = true;
    }
  }
  cout << "HEJ JONATHAN HUR ST�R DET TILL??\n\n";
  return 0;
}
