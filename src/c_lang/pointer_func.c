#include <stdarg.h>

int sum(int a, int b) {
	return a + b;
}

int product(int a, int b) {
	return a * b;
}

double average(double a, double b, ...) {
	va_list parg;
	double sum = a + b;
	double value = 0.0;
	int count = 2;

	va_start(parg, b);

	while((value = va_arg(parg, double)) != 0.0) {
		sum = sum + value;
		++count;
	}
	va_end(parg);
	return sum / count;

}

