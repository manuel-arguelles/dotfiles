CC=g++
CFLAGS=-Wall -Wextra -O2 -std=c++11
LDLIBS=
TARGET=cpu-usage

all: $(TARGET)

$(TARGET): $(TARGET).cpp
	$(CC) $(CFLAGS) -o $(TARGET) $(TARGET).cpp

clean:
	$(RM) $(TARGET)
