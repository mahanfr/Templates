CC = gcc
CFLAGS = -Wall -Wextra
CLIBS = -lpthread
MK_FILE_PATH = $(abspath $(lastword $(MAKEFILE_LIST)))
PROJECT_DIR := $(dir $(MK_FILE_PATH))
SRC_DIR = $(PROJECT_DIR)src
PROGRAM_ENTRY = $(PROJECT_DIR)server.c
BUILD_DIR := $(PROJECT_DIR)build
TARGET_NAME := server
TARGET = $(BUILD_DIR)/$(TARGET_NAME)

rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))
SRC = $(call rwildcard,$(SRC_DIR),*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRC))

.PHONY: server clean

server: always $(TARGET)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@ echo CC $^
	@ $(CC) $(CFLAGS) -c $^ -o $@ $(CLIBS)

$(TARGET): $(PROGRAM_ENTRY) $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(CLIBS)
	@ echo DONE. CREATED $@

always:
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)
