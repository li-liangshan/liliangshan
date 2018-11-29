#include<stdio.h>

void bubble_sort(int arr[], int length) {
	int temp;
	int ex = 0;
	for (int i = length; i > 0; i--) {  //外层循环移动游标
		ex = 0;
    for (int j = 0; j < i && (j+1) < i; j++) {    //内层循环遍历游标及之后(或之前)的元素
      if(arr[j] > arr[j+1]) {
          int temp = arr[j];
          arr[j] = arr[j+1];
          arr[j+1] = temp;
					ex = 1;
       }
     }

     if (ex == 0) {
      return;
     }
   }
}


int main() {
    int arr[] = { 22, 34, 3, 32, 82, 55, 89, 50, 37, 5, 64, 35, 9, 70 };
    int len = (int) sizeof(arr) / sizeof(*arr);
    bubble_sort(arr, len);
    int i;
    for (i = 0; i < len; i++)
    {
      printf("%d ", arr[i]);
    }
    return 0;
}
