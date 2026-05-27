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
ifeq ($(OS),Windows_NT)
	del $(TARGET) *.o
else
	rm -f $(TARGET) *.o
endif