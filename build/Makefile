all: clean build
	@echo "make all done!"

.PHONY: read clean

c_example_1 = c_example_1
c_main_1 = c_main_1
obj = factorial
obj1 = optimize_exp_1
obj2 = optimize_exp_2
bubble = bubble_sort
bubble_no = bubble_sort_no
CC = gcc

VPATH = ../src:../resources

build: ${c_example_1}.c ${c_main_1}.c ${bubble}.c ${obj1}.c ${obj2}.c ${bubble_no}.c
	@${CC} -o $(obj) ${c_example_1}.c ${c_main_1}.c
	@${CC} -o ${obj1} ${obj1}.c
	@${CC} -o ${obj2} ${obj2}.c
	@${CC} -o ${bubble} ${bubble}.c
	@${CC} -o ${bubble_no} ${bubble_no}.c
	@echo "build all done!"

run: $(obj)
	@./$(obj) 5
	@echo 'run ${obj} done!'

read:
	@cat ./optimize_program.md


build_exp_1: ${obj1}.c
	@${CC} -o ${obj1} ${obj1}.c
	@echo 'build ${obj1}.c done!'

run_exp_1:
	@./${obj1}
	@echo 'run ${obj1} done!'

build_exp_2: ${obj2}.c
	@${CC} -o ${obj2} ${obj2}.c
	@echo 'build ${obj2}.c done!'

run_exp_2:
	@./${obj2}
	@echo 'run ${obj2} done!'

build_bubble:
	@${CC} -o ${bubble} ${bubble}.c
	@echo 'build ${bubble}.c done!'

run_bubble:
	@./${bubble}
	@echo 'run ${bubble} done!'

build_bubble_no:
	@${CC} -o ${bubble_no} ${bubble_no}.c
	@echo 'build ${bubble_no}.c done!'

run_bubble_no:
	@./${bubble_no}
	@echo 'run ${bubble_no} done!'

clean:
	@-rm $(obj) ${obj1} ${obj2} ${bubble} ${bubble_no}
	@echo "clean done!"


