NASM := nasm
LD   := ld

NASMFLAGS := -f elf64 -g -F dwarf
LDFLAGS   := -z noexecstack

SRC_DIR := src
OBJ_DIR := bin/obj
BIN_DIR := bin/out

TARGET := $(BIN_DIR)/calculator
SRCS   := $(wildcard $(SRC_DIR)/*.asm)
OBJS   := $(patsubst $(SRC_DIR)/%.asm,$(OBJ_DIR)/%.o,$(SRCS))

all: fix_time $(TARGET)

fix_time:
	@touch $(SRC_DIR)/*.asm 2>/dev/null || true
	@touch include/*.inc 2>/dev/null || true

$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(LD) $(LDFLAGS) $^ -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	@mkdir -p $(OBJ_DIR)
	$(NASM) $(NASMFLAGS) $< -o $@

run: $(TARGET)
	./$(TARGET)

clean:
	rm -rf bin

.PHONY: all fix_time run clean