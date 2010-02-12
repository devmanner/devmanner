#ifndef COMMON_H
#define COMMON_H

#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

typedef enum boolean {FALSE, TRUE} Boolean;

unsigned int getInt(void);

void Error(char *message);

void Warning(char *message);

#endif