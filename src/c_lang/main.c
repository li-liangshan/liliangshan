#include <stdio.h>
#include "pointer_func.h"
#include "horse_next.h"

int main(int argc, char* argv[]) {

	for(int i =0; i < argc; i++) {
		printf("pointer argv:%s \n", argv[i]);
	}


	int (*p_sum)(int, int) = sum;
	int sum_int = p_sum(1, 3);
	printf("pointer sum: %d\n", sum_int);

	int (*p_array[2])(int, int);
	p_array[0] = sum;
	p_array[1] = product;

	int (*p_d_array[])(int, int) = {sum, product};

	int p_d_array_sum = p_d_array[0](1, 4);
  printf("p_d_array_sum ---------> %d\n", p_d_array_sum);
  int p_d_array_product = p_d_array[1](3, 4);
  printf("p_d_array_product ---------> %d\n", p_d_array_product);

	int p_array_sum = p_array[0](1, 4);
	printf("p_array_sum ---------> %d\n", p_array_sum);
	int p_array_product = p_array[1](3, 4);
	printf("p_array_product ---------> %d\n", p_array_product);

	double avg = average(3.0, 4.0, 5.0, 6.0);
	printf("average parg ---------> %f\n", avg);

//	struct Horse horse = { 20, 15, "horse name", "horse father name", "horse mother name" };
//
//	printf("horse struct name:%s\n", horse.name);
//	printf("horse struct father name:%s\n", horse.father);
//	printf("horse struct mother name:%s\n", horse.mother);
//
//	Horse_t horse_t = { 20, 15, "horse_t name", "horse_t father name", "horse_t mother name" };
//	printf("horse struct name:%s\n", horse_t.name);
//  printf("horse struct father name:%s\n", horse_t.father);
//  printf("horse struct mother name:%s\n", horse_t.mother);
//
//  printf("horse struct name:%s\n", global_horse.name);
//  printf("horse struct father name:%s\n", global_horse.father);
//  printf("horse struct mother name:%s\n", global_horse.mother);


//  test_horse_next();
	test_thread();
}
