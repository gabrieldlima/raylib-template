RAYLIB ?= $(HOME)/.local
RAYLIB_INCLUDE_DIR ?= $(RAYLIB)/include
RAYLIB_LIB_DIR ?= $(RAYLIB)/lib

all:
	gcc src/main.c -I $(RAYLIB_INCLUDE_DIR) -L $(RAYLIB_LIB_DIR) -lraylib -lGL -lm -lpthread -ldl -lrt -lX11

clean:
	rm a.out
