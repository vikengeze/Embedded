CC = gcc

CFLAGS = -Wall
CFLAGS += -O0
CFLAGS += -mcmodel=large

BINS = tables

all: $(BINS)

tables: tables.c
	$(CC) $(CFLAGS) -o $@ $<

