all: clean build
	@echo "make all done!"

.PHONY: all read

obj = factorial
obj1 = optimize_exp_1
obj2 = optimize_exp_2
bubble = bubble_sort

VPATH = ../src:../resources

build: c_example_1.c c_main_1.c ${bubble}.c ${obj1}.c ${obj2}.c
	@gcc -o $(obj) c_example_1.c c_main_1.c
	@gcc -o ${obj1} ${obj1}.c
	@gcc -o ${obj2} ${obj2}.c
	@gcc -o ${bubble} ${bubble}.c
	@echo "build all done!"

run: $(obj)
	@./$(obj) 5

clean:
	@-rm $(obj) ${obj1} ${obj2} ${bubble}
	@echo "Clean done!"

read:
	@cat ./optimize_programmer.md


build_exp_1: ${obj1}.c
	@gcc -o ${obj1} ${obj1}.c
	@echo 'build ${obj1}.c done!'

run_exp_1:
	@./${obj1}

build_exp_2: ${obj2}.c
	@gcc -o ${obj2} ${obj2}.c
	@echo 'build ${obj2}.c done!'

run_exp_2:
	@./${obj2}
	@echo 'run ${obj2} done!'

build_bubble:
	@gcc -o ${bubble} ${bubble}.c
	@echo 'build ${bubble}.c done!'

run_bubble:
	@./${bubble}
	@echo 'run ${bubble} done!'


