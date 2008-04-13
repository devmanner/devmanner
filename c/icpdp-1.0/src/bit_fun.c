#include "../include/bit_fun.h"

/*
 * Print a byte as hex with 2 digit precision. Return the byte to make the function work with for_each.
 */

UBYTE print_byte(UBYTE b) {
  printf("%02x", b);
  return b;
}


UTWOBYTE merge_2bytes(UBYTE x, UBYTE y) {
  UTWOBYTE ret = x;
  ret = ret << 8;
  ret = ret | y;
  return ret;
}

UFOURBYTE merge_4bytes(UBYTE x1, UBYTE x2, UBYTE x3, UBYTE x4) {
  UFOURBYTE ret = x1;
  ret = ret << 8;
  ret = ret | x2;
  ret = ret << 8;
  ret = ret | x3;
  ret = ret << 8;
  ret = ret | x4;
  return ret;
}


/* Get a bit from a byte array. Bit 0 is LSB. Bits are numbered (2 bytes in this example):
 * | 7 6 5 4 3 2 1 0 | 15 14 13 12 11 10 9 8 |
 * Pre: a is a pointer to a memory area.
 */
UBYTE get_bit(UBYTE *a, size_t index) {
  /* Iterate forward to the byte in a where start is. */
  while (index > 8) {
    /* printf("A: %d 0x%02x index: %d\n", *a, *a, index); */
    ++a;
    index -= 8;
  }
  return ( (*a) >> index ) & 0x1;
}


/*
 * Get the bits in range start to stop.
 * Pre: a is a valid pointer. Range (start-stop) <= 16.
 * Post: Returned value is the the range from start to stop with stop at LSB.
*/

UTWOBYTE get_bit_range2(const UBYTE* a, size_t start, size_t stop) {
  UTWOBYTE ret;
  UTWOBYTE mask=0;
  unsigned int i;
  assert(a);
  assert(stop-start < 16);

  /* Iterate forward to the index in a where start is. */
  /*
  while (start > 8) {
    ++a;
    start -= 8;
    stop -= 8;
  }
  */
  stop = stop - start;
  start = start & 7;
  stop += start;
  a -= (start << 3);

  /* Shift down the bits. */
  for (i = stop, ret = merge_2bytes(a[0], a[1]); i < 15; ++i)
    ret >>= 1;

  /* Create a mask to mask off the beginning bits. */
  for (i = 0; i < stop-start+1; ++i)
    mask = mask ^ (1 << i);

  return ret & mask;
}

/*
 * Get the bits in range start to stop.
 * Pre: a is a valid pointer. Range (start-stop) < 32, start <= stop.
 * Post: Returned value is the the range from start to stop with stop at LSB.
*/
UFOURBYTE get_bit_range4(UBYTE* a, size_t start, size_t stop) {
  union {
    struct {
      UFOURBYTE fb1;
      UFOURBYTE fb2;
    } fourbytes;
    UBYTE bytes[8];
  } converter;

  UFOURBYTE ret=0;
  int i, bit;

  assert(a);
  assert(stop-start < 32);
  assert(start <= stop);
  
  converter.fourbytes.fb2 = converter.fourbytes.fb1 = 0;

  /* Iterate forward to the index in a where start is. */
  while (start >= 8) {
    ++a;
    start -= 8;
    stop -= 8;
  }
  
  /* If requesting just one bit. */
  if (start == stop)
    return get_bit(a, 7-start);
  
  /* Copy from a to the converters array. */
  for (i = 0, bit = 0; bit < stop ; bit += 8, ++i)
    converter.bytes[i] = a[i];
  
  ret = (converter.fourbytes.fb1) << start;
  ret = ret | ((converter.fourbytes.fb2) >> start);
  ret = ret >> (32 - (stop-start+1));
  return ret;
}

/*
 * Description: Extract a TWOBYTE (2 bytes) from sz where sz is a
 * zero-terminated string with a hexadecimal value where all non
 * digits are lowercase.
 * Pre: sz is a valid pointer.
 * Post: A value is returned.
 */
UBYTE hex_extract(const char *sz) {
  return ( ( (UBYTE)sz[0] - (isdigit((int)sz[0]) ? '0' : ('a'-10) ) ) << 4 ) |
    ( (UBYTE)sz[1] - (isdigit((int)sz[1]) ? '0' : ('a'-10) ) );
}
