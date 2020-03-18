
.PHONY: clean

pointer_1 = pointer_1
pointer_main = pointer_main
memory = memory
#CC = gcc

clean:
	@rm -f ./${pointer_main}

run: $(pointer_main)
	@./$(pointer_main)
	@echo 'run ${pointer_main} done!'

build: $(pointer_1).c  $(memory).c
	@$(CC) -o $(pointer_main) $(pointer_1).c $(pointer_main).c $(memory).c
	@echo "build done!"

hee: $(memory)
	@echo "this is test memory"

main: main.c pointer_func.c horse_next.c
	@$(CC) -o main main.c pointer_func.c horse_next.c
	@echo "====== build p_sum_test done! ======"
	@./main arg01 arg02 arg03 arg04
	@echo "====== run ok! ======"
	@rm -f ./main
	@echo "====== clean p_sum_test done! ======"

epoll_example: epoll_example.c
	@$(CC) -o epoll_example epoll_example.c
	@rm -f ./epoll_example
