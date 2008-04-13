#include "matrix.h"
#include <iostream.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

///////////////////////////
// KONSTRUKTOR & DESTRUKTOR
///////////////////////////

Matrix::Matrix(int r, int c, MatrixMode mode) {

	rows = r;
	cols = c;
   if (rows + cols == 0)
		return;

   matrix = new int*[rows];
	for (int i = 0 ; i < rows ; i ++)
		matrix[i] = new int[cols];

   switch (mode) {
		case ZERO:
   //  		cout << "ZERO: kolumner: " << cols << " Rader " << rows << endl;
			for (r = 0 ; r < rows ; r ++)
				for (c = 0 ; c < cols ; c ++)
					matrix[r][c] = 0;

		break;
		case IDENTETY:
	  //		cout << "IDENTETY: kolumner: " << cols << " Rader " << rows << endl;
			if (cols != rows) {
				cout << "Cannot be set to IDENTETY while rows (" << rows << ") not equals cols (" << cols << ")." << endl;
				break;
			}
			for (r = 0 ; r < rows ; r ++)
				for (c = 0 ; c < cols ; c ++)
					matrix[r][c] = (r == c) ? 1 : 0;
			break;
		case RANDOM:
			srand(time(NULL));
			for (r = 0 ; r < rows ; r ++)
				for (c = 0 ; c < cols ; c ++)
					matrix[r][c] = rand() % (MATRIX_RAND_MAX + abs(MATRIX_RAND_MIN) + 1) + MATRIX_RAND_MIN;
		break;
		default:
		break;
	}
}

// Kopieringskonstruktor.
Matrix::Matrix(const Matrix &m) {
 	int r,c;
	rows = m.GetRows();
	cols = m.GetCols();

   matrix = new int*[rows];
	for (int i = 0 ; i < rows ; i ++)
		matrix[i] = new int[cols];

	for (r = 0 ; r < rows ; r ++)
		for (c = 0 ; c < cols ; c ++)
			matrix[r][c] =  m.GetValue(r, c);
}

Matrix::~Matrix() {
	for (int r = 0 ; r < rows ; r ++)
		delete [] matrix[r];
   delete [] matrix;
}

//////////////////////////
// ?VERLAGRADE OPERATORER.
//////////////////////////

Matrix Matrix::operator+(const Matrix &m) const {
	int c, r;
	if (cols != m.GetCols() || rows != m.GetRows()) {
		cerr << "Cannot add! Different sizes!" << endl;
		return *this;
	}

	Matrix tmp(rows, cols);
	for (r = 0 ; r < rows ; r ++)
		for (c = 0; c < cols ; c ++)
			tmp.SetValue(r,c,(matrix[r][c] + m.GetValue(r, c)));
   return tmp;
}

Matrix Matrix::operator-(const Matrix &m) const {
	if (cols != m.GetCols() && rows != m.GetRows()) {
		cerr << "Cannot subtract! Different sizes!" << endl;
		return *this;
	}

	Matrix tmp(rows, cols);
	for (int r = 0 ; r < rows ; r ++)
		for (int c = 0 ; c < cols ; c ++)
			tmp.matrix[r][c] = matrix[r][c] - m.matrix[r][c];
	return tmp;
}

Matrix Matrix::operator*(const Matrix &m) const {
        int i, j, k;
	if (cols != m.GetRows()) {
		cerr << "Cannot multiply! The sizes does not match!" << endl;
		return *this;
	}

	Matrix tmp(rows, m.GetCols(), ZERO);
        for (i = 0; i < tmp.GetCols();i ++)
                for (j = 0; j < tmp.GetRows(); j ++) {
                        for (k = 0; k < cols; k ++) {
                                tmp.matrix[i][j] = tmp.matrix[i][j] + matrix[i][k] * m.GetValue(k, j);
                        }
                }
        return tmp;
}

bool Matrix::operator==(const Matrix &m) const {
	if (cols != m.GetCols() && rows != m.GetRows())
		return false;

	for (int r = 0 ; r < rows ; r ++)
		for (int c = 0 ; c < cols ; c ++)
			if (matrix[r][c] != m.matrix[r][c])
				return false;
	return true;
}

Matrix& Matrix::operator=(const Matrix &m) {
	int r, c;
	if (*this == m)
		return *this;

	for (r = 0 ; r < rows ; r ++)
		delete [] matrix[r];
	delete [] matrix;

	rows = m.GetRows();
	cols = m.GetCols();

	matrix = new int*[rows];
	for (r = 0 ; r < rows ; r ++)
		matrix[r] = new int[cols];

	for (r = 0 ; r < rows ; r ++)
		for (c = 0 ; c < cols ; c ++)
			matrix[r][c] = m.matrix[r][c];
	return *this;
}

// Version med "adjustment"
ostream &operator<<(ostream &os, const Matrix &m){
	int r, c, spaces;

	for (r = 0 ; r < m.GetRows() ; r ++) {
		for (c = 0 ; c < m.GetCols() ; c ++) {
                        spaces = 3;
			os << m.GetValue(r,c);

                        if (m.GetValue(r,c) < 0)
                                spaces --;
                        if (abs(m.GetValue(r,c)) > 10)
                                spaces --;
                        for (int i = 0; i < spaces; i++)
                                cout << " ";
                }
		os << endl;
	}
   return os;
}

// Original
/*ostream &operator<<(ostream &os, const Matrix &m){
	int r, c;
	for (r = 0 ; r < m.GetRows() ; r ++) {
		for (c = 0 ; c < m.GetCols() ; c ++)
			os << m.GetValue(r,c) << " ";
		os << endl;
	}
   return os;
}*/
///////////////
// ?VRIGT SKR?
///////////////

void Matrix::Print() const {
	int r, c;
	for (r = 0 ; r < rows; r ++) {
		for (c = 0 ; c < cols ; c ++)
			cout << matrix [r][c] << " ";
		cout << endl;
	}
}

