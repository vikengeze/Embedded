CC=gcc
CFLAGS=-Wall -g -c

all: string_manipulation.o strcat.o strcmp.o strcpy.o strlen.o string_manipulation.out

string_manipulation.o: string_manipulation.c
	$(CC) $(CFLAGS) $< -o $@
strcat.o: strcat.s
	$(CC) $(CFLAGS) $< -o $@
strcmp.o: strcmp.s
	$(CC) $(CFLAGS) $< -o $@
strcpy.o: strcpy.s
	$(CC) $(CFLAGS) $< -o $@
strlen.o: strlen.s
	$(CC) $(CFLAGS) $< -o $@

string_manipulation.out: string_manipulation.o strcat.o strcmp.o strcpy.o strlen.o
	$(CC) $^ -o $@

clean:
	rm *.o


