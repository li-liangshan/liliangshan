#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <threads.h>
#include "horse_next.h"



void test_horse_next() {
	HorseNext *first = NULL;
	HorseNext *current = NULL;
	HorseNext *previous = NULL;

	char test = '\0';

	for (;;) {
		printf("Do you want to enter details of a%s horse (Y or N)? ", first != NULL ? "nother" : "");
		scanf(" %c", &test);
		if (tolower(test) == 'n') {
			break;
		}

		current = (HorseNext*) malloc(sizeof(HorseNext));
		if (first == NULL) {
			first = current;
		}

		if (previous != NULL) {
			previous->next = current;
		}

		printf("Enter the name of the horse: ");
		scanf("%s", current->name);

		printf("How old is %s ? ", current->name);
		scanf("%d", &current->age);

		printf("How high is %s (in hands)? ", current->name);
		scanf("%d", &current->height);

		printf("Who is %s's father? ", current->name);
		scanf("%s", current->father);

		printf("Who is %s's mother? ", current->name);
    scanf("%s", current->mother);

    current->next = NULL;
    previous = current;
	}

	printf("\n");
	current = first;
	while(current != NULL) {
		printf("%s is %d years old, %d hands high,", current->name, current->age, current->height);
		printf(" and has %s and %s as parents.\n", current->father, current->mother);

		previous = current;
		current = current->next;
		free(previous);
		previous = NULL;
	}

	first = NULL;
}

typedef struct ThreadData {

		thrd_t id;
		int a;
		int b;

} ThreadData;

int get_data(void *p_data) {

	ThreadData *pd = (ThreadData*)p_data;
	printf("The get data thread received: data.a=%d and data.b=%d\n", pd->a, pd->b);

	int mul = 0;
	printf("Enter an integer multiplier:\n");
	scanf("%d", &mul);
	pd->a *= mul;

	printf("the get data thread makes it : data.a=%d and data.b=%d\n", pd->a, pd->b);

	return 0;

}

int process_data(void* p_data) {
	ThreadData *pd = (ThreadData*)p_data;
	int result = 0;
	if (thrd_error == thrd_join(pd->id, &result)) {
		fprintf(stderr, " get data thread join by process data failed.\n");
		thrd_exit(-1);
	}

	if (result == -1) {
		fprintf(stderr, " get data thread join by process data failed.\n");
		thrd_exit(-2);
	}

	printf(" the process data thread received: data.a=%d and data.b=%d\n", pd->a, pd->b);
	thrd_exit(0);

}

int test_thread() {

	thrd_t process_id;
	ThreadData data = { .a=123, .b=345 };
	printf("Before starting the get data thread received: my_data.a=%d and my_data.b=%d\n", data->a, data->b);

	switch(thrd_create(&data.id, get_data, &data)) {
		case thrd_success:
			printf("get data thread starting \n");
			break;
		case thrd_nomem:
			fprintf(stderr, "failed to start get data thread.\n");
			exit(1);
		case thrd_error:
			fprintf(stderr, "failed to start process data thread.\n");
      exit(1);
	}

	thrd_join(process_id, NULL);
	printf("After both thread finished the get data thread received: my_data.a=%d and my_data.b=%d\n", data->a, data->b);
	return 0;
}
