#include "jltio.h"

static ssize_t my_read(int fd, char *ptr)
{
	static int	read_cnt = 0;
	static char	*read_ptr;
	static char	read_buf[MAXLINE];

	if (read_cnt <= 0) {
again:
		if ( (read_cnt = read(fd, read_buf, sizeof(read_buf))) < 0) {
			if (errno == EINTR)
				goto again;
			return(-1);
		} else if (read_cnt == 0)
			return(0);
		read_ptr = read_buf;
	}

	read_cnt--;
	*ptr = *read_ptr++;
	return(1);
}

ssize_t readline(int fd, void *vptr, size_t maxlen)
{
	int		n, rc;
	char	c, *ptr;

	ptr = vptr;
	for (n = 1; n < maxlen; n++) {
		if ( (rc = my_read(fd, &c)) == 1) {
			*ptr++ = c;
			if (c == '\n')
				break;	/* newline lagras, som fgets() */
		} else if (rc == 0) {
			if (n == 1)
				return(0);	/* EOF, inget data var l�st */
			else
				break;		/* EOF, lite data var l�st */
		} else
			return(-1);		/* error, errno satt av read() */
	}

	*ptr = 0;	/* null terminate som fgets() */
	return(n);
}
/* end readline */

