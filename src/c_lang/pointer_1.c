#include <stdio.h>

void pointer_test() {
  int number = 0;
  int *p_number = NULL;

  number = 10;
  printf("number's address: %p\n", &number);
  printf("number's value: %d\n\n", number);

  p_number = &number;
  printf("p_number's address: %p\n", (void *)&p_number);
  printf("p_number's size: %zd bytes\n", sizeof(p_number));
  printf("p_number's value: %p\n", p_number);
  printf("value pointed to: %d\n", *p_number);
}


void pointer_malloc() {

}
