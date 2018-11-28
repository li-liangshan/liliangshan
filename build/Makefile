all: clean build
.PHONY: all

obj = factorial.out
VPATH = ../src:../resources

build: c_example_1.c c_main_1.c
	@gcc -o $(obj) c_example_1.c c_main_1.c

run: $(obj)
	@./$(obj) 5

clean:
	@rm $(obj)
