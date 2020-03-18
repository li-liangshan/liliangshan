int sum(int a, int b);

int product(int a, int b);

double average(double a, double b, ...);

struct Horse {
	int age;
	int height;
	char name[30];
	char father[30];
	char mother[30];
};

// global typedef struct
typedef struct Horse Horse_t;

// global variable
Horse_t global_horse = { 20, 15, "horse_t global name", "horse_t global father name", "horse_t global mother name" };

struct Date {
	int day;
	int month;
	int year;
};

typedef struct Date Date_t;
