CC = gcc
CXX = g++

CFLAGS = -Isrc/include/ -Wall -Werror -O2 -std=c23 -fPIC
CXXFLAGS = -Isrc/include/ -Wall -Werror -O2 -std=c++23 -fPIC

BUILD_DIR = build
BIN_DIR = bin

TARGET_CLI = $(BIN_DIR)/rv32i_sim
TARGET_DPI = $(BIN_DIR)/rv32i_iss.so

CORE_C_SRCS = $(wildcard src/core/*.c)
CORE_CPP_SRCS = $(wildcard src/core/*.cpp)

CLI_C_SRCS = $(wildcard src/cli/*.c)
CLI_CPP_SRCS = $(wildcard src/cli/*.cpp)

DPI_C_SRCS = $(wildcard src/dpi/*.c)
DPI_CPP_SRCS = $(wildcard src/dpi/*.cpp)

CORE_OBJS = $(patsubst src/%.c, $(BUILD_DIR)/%.o, $(CORE_C_SRCS)) \
            $(patsubst src/%.cpp, $(BUILD_DIR)/%.o, $(CORE_CPP_SRCS))

CLI_OBJS = $(patsubst src/%.c, $(BUILD_DIR)/%.o, $(CLI_C_SRCS)) \
           $(patsubst src/%.cpp, $(BUILD_DIR)/%.o, $(CLI_CPP_SRCS))

DPI_OBJS = $(patsubst src/%.c, $(BUILD_DIR)/%.o, $(DPI_C_SRCS)) \
           $(patsubst src/%.cpp, $(BUILD_DIR)/%.o, $(DPI_CPP_SRCS))

.PHONY: all clean run

all: $(TARGET_CLI) $(TARGET_DPI)

# ------------ CLI BUILD ------------
$(TARGET_CLI): $(CORE_OBJS) $(CLI_OBJS) | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@
# -----------------------------------

# ------------ LIB BUILD ------------
$(TARGET_DPI): $(CORE_OBJS) $(DPI_OBJS) | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -shared $^ -o $@
# -----------------------------------

$(BUILD_DIR)/%.o: src/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: src/%.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BIN_DIR):
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR)/ $(BIN_DIR)/
