#ifndef BIT_FUN_H_INCLUDED
#define BIT_FUN_H_INCLUDED

#include <assert.h>
#include <ctype.h>
#include <stdio.h>

#include "types.h"
UBYTE print_byte(UBYTE b);

UTWOBYTE merge_2bytes(UBYTE x, UBYTE y);
UFOURBYTE merge_4bytes(UBYTE x1, UBYTE x2, UBYTE x3, UBYTE x4);

/* Get a bit from a byte array. Bit 0 is LSB. Bits are numbered (2 bytes in this example):
 * | 15 14 13 12 11 10 9 8 | 7 6 5 4 3 2 1 0 |
 * Pre: a is a pointer to a memory area.
 */
UBYTE get_bit(UBYTE *a, size_t index);

/*
 * Get the bits in range start to stop.
 * Pre: a is a valid pointer. Range (start-stop) <= 16.
 * Post: Returned value is the the range from start to stop with stop at LSB.
*/
UTWOBYTE get_bit_range2(const UBYTE* a, size_t start, size_t stop);

/*
 * Get the bits in range start to stop.
 * Pre: a is a valid pointer. Range (start-stop) < 32, start <= stop.
 * Post: Returned value is the the range from start to stop with stop at LSB.
*/
UFOURBYTE get_bit_range4(UBYTE* a, size_t start, size_t stop);

/*
 * Description: Extract a TWOBYTE (2 bytes) from sz where sz is a
 * zero-terminated string with a hexadecimal value where all non
 * digits are lowercase.
 * Pre: sz is a valid pointer.
 * Post: A value is returned.
 */
UBYTE hex_extract(const char *sz);

#endif
