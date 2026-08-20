CC = gcc
CXX = g++

CFLAGS = -Isrc/include/ -Wall -Werror -O2 -std=c23 -fPIC
CXXFLAGS = -Isrc/include/ -Wall -Werror -O2 -std=c++23 -fPIC

BUILD_DIR = build
BIN_DIR = bin
SRC_DIR = src

TARGET_CLI = $(BIN_DIR)/rv32i_sim
TARGET_DPI = $(BIN_DIR)/rv32i_uvm_iss.so

C_SRCS = $(wildcard $(SRC_DIR)/*.c)
CPP_SRCS = $(wildcard $(SRC_DIR)/*.cpp)

# both .c and .cpp options included in case i switch to either language during development
CORE_C_SRCS = $(filter-out $(SRC_DIR)/main.c $(SRC_DIR)/dpi_wrapper.c, $(C_SRCS))
CORE_CPP_SRCS = $(filter-out $(SRC_DIR)/main.cpp $(SRC_DIR)/dpi_wrapper.cpp, $(CPP_SRCS))

CORE_OBJS = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(CORE_C_SRCS)) \
			$(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(CORE_CPP_SRCS))

.PHONY: all clean run

all: $(TARGET_CLI) $(TARGET_DPI)

# ------------ CLI BUILD ------------
$(TARGET_CLI): $(CORE_OBJS) $(BUILD_DIR)/main.o | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@
# -----------------------------------

# ------------ LIB BUILD ------------
$(TARGET_DPI): $(CORE_OBJS) $(BUILD_DIR)/dpi_wrapper.o | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -shared $^ -o $@
# -----------------------------------

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR) $(BIN_DIR):
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR)/ $(BIN_DIR)/

run: $(TARGET_CLI)
	@clear
	./$(TARGET_CLI)