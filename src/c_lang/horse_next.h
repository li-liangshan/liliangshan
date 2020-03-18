#define __STDC_WANT_LIB_EXT1__ 1

void test_horse_next();
int test_thread();

typedef struct HorseNext HorseNext;

struct HorseNext {
	int age;
	int height;
	char name[20];
	char father[20];
	char mother[20];
	HorseNext *next;
};



