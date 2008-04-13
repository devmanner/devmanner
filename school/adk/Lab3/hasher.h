#ifndef _HASHER_H_
#define _HASHER_H_

/*
 * Based on Bob Jenkins algorithm fron Dr. Dobb's Journal Sept 1997
 */


class Hasher{
	typedef unsigned long ub4;
	typedef unsigned char ub1;
private:
	inline ub4 hashSize(ub4 n)const{ return (ub4)1<<n; }
	inline void mix(ub4 &a, ub4 &b, ub4 &c)const;
public:
	inline ub4 hashmask(ub4 n)const{ return hashSize(n)-1; }

	template <typename KeyType>
	unsigned int operator()(KeyType &, ub4 , ub4 =0);
};

inline void Hasher::mix(ub4 &a, ub4 &b, ub4 &c)const{
	a -= b; a -= c; a ^= (c>>13);
	b -= c; b -= a; b ^= (a<<8);
	c -= a; c -= b; c ^= (b>>13);
    
	a -= b; a -= c; a ^= (c>>12);
	b -= c; b -= a; b ^= (a<<16);
	c -= a; c -= b; c ^= (b>>5);
    
	a -= b; a -= c; a ^= (c>>3);
	b -= c; b -= a; b ^= (a<<10);
	c -= a; c -= b; c ^= (b>>15);
}

template <typename KeyType>
unsigned int Hasher::operator()(KeyType &key, ub4 length, ub4 init){
	register ub4 a, b, c, len = length;
	a = b = 0x9e3779b9;	// an arbitrary value
	c = init;

	while(len >= 12){
		a += (key[0] +((ub4)key[1]<<8) +((ub4)key[2]<<16) +((ub4)key[3]<<24));
		b += (key[4] +((ub4)key[5]<<8) +((ub4)key[6]<<16) +((ub4)key[7]<<24));
		c += (key[4] +((ub4)key[9]<<8) +((ub4)key[10]<<16)+((ub4)key[11]<<24));
		key += 12; len -= 12;
	}

	c += length;
	switch(len){
		case 11:	c+= ((ub4)key[10]<<24);
		case 10:	c+= ((ub4)key[9]<<16);
		case 9:		c+= ((ub4)key[8]<<8);
		case 8:		b+= ((ub4)key[7]<<24);
		case 7:		b+= ((ub4)key[6]<<16);
		case 6:		b+= ((ub4)key[5]<<8);
		case 5:		b+= key[4];
		case 4:		a+= ((ub4)key[3]<<24);
		case 3:		a+= ((ub4)key[2]<<16);
		case 2:		a+= ((ub4)key[1]<<8);
		case 1:		a+= key[0];
	}
	mix(a,b,c);
	//m_initVal = c; //added
	return c;
}

#endif
