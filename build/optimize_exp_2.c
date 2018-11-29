#include<stdio.h>
#include <stdlib.h>

long f();

long func1() {
	return f() + f() + f() + f();
}

long func2() {
	return 4 * f();
}

int counter = 0;
long f() {
	return counter++;
}

int main(int argc, char **argv) {
	long a = func1();
	printf("a = %ld\n", a);

	counter = 0;
	long b = func2();
	printf("b = %ld\n", b);
}
