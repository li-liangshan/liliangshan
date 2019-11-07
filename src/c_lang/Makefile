
.PHONY: clean

pointer_1 = pointer_1
pointer_main = pointer_main
CC = gcc

build: ${pointer_1}.c
	@${CC} -o ${pointer_main} ${pointer_1}.c ${pointer_main}.c
	@echo "build done!"


run: $(pointer_main)
	@./$(pointer_main)
	@echo 'run ${pointer_main} done!'

clean:
	@rm -f ./${pointer_main}



