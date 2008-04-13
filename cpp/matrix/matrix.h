#ifndef _MATRIX_H_
#define _MATRIX_H_

#include <fstream.h>

#define MATRIX_RAND_MAX 10
#define MATRIX_RAND_MIN -10

//typedef enum {false, true} bool;

enum MatrixMode {ZERO = 1, IDENTETY = 2, RANDOM = 3};

class Matrix {
public:
	Matrix(int =0, int =0, MatrixMode = (MatrixMode)0);
	Matrix(const Matrix &);
	~Matrix();

	int GetRows() const {return rows;}
	int GetCols() const {return cols;}
	int GetValue(int r, int c) const {return matrix[r][c];}
	void SetValue(int r, int c, int value) { matrix[r][c] = value;}
	void Print () const;

	Matrix operator+(const Matrix &) const;
	Matrix operator-(const Matrix &) const;
	Matrix operator*(const Matrix &) const;
	bool operator==(const Matrix &) const;
	Matrix& operator=(const Matrix &);

friend ostream &operator<<(ostream &, const Matrix &);

private:
	int **matrix;
	int rows;
	int cols;
};

#endif
