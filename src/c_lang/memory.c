#include <stdlib.h>
#include <stdio.h>

int* count_int_malloc(int count) {
	printf(" count: %d\n", count);
	return (int*) malloc(count * sizeof(int));
}

int* count_long_malloc(int count) {
	printf(" count: %d\n", count);
	return (int*) malloc(count * sizeof(long));
}

void free_memory(int* pointer) {
	free(pointer);
}
