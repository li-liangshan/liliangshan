#include<stdio.h>
#include <stdlib.h>

void swap(long *xp, long *yp) {
	*xp = *xp + *yp;
	*yp = *xp - *yp;
	*xp = *xp - *yp;
}


int main(int argc, char **argv) {
	long a = 4, b = 5;
	long *xp = &a, *yp = &b;
	swap(xp, yp);
	printf("xp = %ld , yp = %ld\n", *xp, *yp);

	a = 4;
	b = 5;
	long *t_xp = &a, *t_yp = &a;
	swap(t_xp, t_yp);
	printf("t_xp = %ld , t_yp = %ld\n", *t_xp, *t_yp);
}
