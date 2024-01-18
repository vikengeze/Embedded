CC = gcc
CFLAGS = -O0 -c
CFLAGS += -mcmodel=large

all: tables tables_exhaustive tables_random tables_simplex

tables.o: tables.c 
	$(CC) $(CFLAGS) tables.c

tables: tables.o
	$(CC) tables.o -o tables

tables_exhaustive.o: tables_exhaustive.c 
	$(CC) $(CFLAGS) tables_exhaustive.c

tables_exhaustive: tables_exhaustive.o
	$(CC) tables_exhaustive.o -o tables_exhaustive

tables_random.o: tables_random.c 
	$(CC) $(CFLAGS) tables_random.c

tables_random: tables_random.o
	$(CC) tables_random.o -o tables_random

tables_simplex.o: tables_simplex.c 
	$(CC) $(CFLAGS) tables_simplex.c

tables_simplex: tables_simplex.o
	$(CC) tables_simplex.o -o tables_simplex

.PHONY : clean

clean:
	-rm -f tables.o tables_exhaustive.o tables_random.o tables_simplex.o
