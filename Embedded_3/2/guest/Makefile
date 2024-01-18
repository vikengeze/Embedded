CC = gcc
CFLAGS = -Wall -g 

all: guest.out

guest.out: guest.s
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm guest.out
