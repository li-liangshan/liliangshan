#include <stdio.h>
#include "pointer_1.h"
#include "memory.h"

int main(void)
{

	int* p = count_int_malloc(10);
	free_memory(p);
  pointer_test();
  int number = 100;
  const int *a = &number; // 指向常量的指针， 指针指向一个常量
  int *const p_count = &number; // 常量指针，也就是指针指向的地址不能改变。

  return 0;
}
