#include "matrix.h"
#include <iostream.h>
//#include <conio.h>

int main() {
	Matrix m1(4, 4, IDENTETY);
	Matrix m2(4, 4, RANDOM);
	Matrix m3(4, 4, ZERO);

	cout << m1 << endl << m2 << endl;

        m3 = m1 * m2;
	cout << m3 << endl;

        if (m2 == m3)
                cout << "m2 equals m3";
        else
                cout << "m2 doesn't equal m3";
        cout << endl;
	return 0;
}
