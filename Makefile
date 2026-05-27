TARGET = blast-dbf
CC ?= cc
CFLAGS ?=

ifeq ($(OS),Windows_NT)
    TARGET := $(TARGET).exe
endif

$(TARGET): blast-dbf.c blast.c blast.h
	$(CC) $(CFLAGS) -o $(TARGET) blast.c blast-dbf.c

test: $(TARGET)
ifeq ($(OS),Windows_NT)
	@echo "Skipping test on Windows"
else
	./$(TARGET) < sids.dbc | cmp - sids.dbf
endif

clean:
	rm -f blast-dbf blast-dbf.exe *.o