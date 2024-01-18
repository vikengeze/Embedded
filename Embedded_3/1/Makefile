CC=gcc
CFLAGS=-Wall -g -c

all: ex_3_1.o ex_3_1_func.o ex_3_1

ex_3_1.o: ex_3_1.s
	$(CC) $(CFLAGS) $< -o $@

ex_3_1_func.o: ex_3_1_func.s
	$(CC) $(CFLAGS) $< -o $@
	
ex_3_1: ex_3_1.o ex_3_1_func.o
	$(CC) $^ -o $@

clean:
	rm *.o
	rm ex_3_1
