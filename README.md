# ASM Syscall Calculator

<p align="center">

<img src="https://img.shields.io/badge/Assembly-x86--64-blue">
<img src="https://img.shields.io/badge/NASM-2.x-success">
<img src="https://img.shields.io/badge/Linux-Syscalls-red">
<img src="https://img.shields.io/badge/Linux-x86__64-black?logo=linux">
<img src="https://img.shields.io/badge/License-MIT-yellow">

</p>

🇬🇧 English | 🇷🇺 [Русский](README_RU.md)

A simple command-line calculator written in x86-64 Assembly using raw Linux system calls (without libc).

## Features

- Integer addition
- Integer subtraction
- Integer multiplication
- Integer division
- Division-by-zero handling
- Manual string-to-integer conversion
- Manual integer-to-string conversion
- Raw Linux syscalls (`read`, `write`, `exit`)
- No libc
- NASM syntax

## Requirements

- Linux
- NASM
- GNU LD
- GNU Make

## Build

```bash
make
```

Manual build:

```bash
nasm -f elf64 src/main.asm -o bin/obj/main.o
ld bin/obj/main.o -o bin/out/calculator
```

## Run

```bash
make run
```

or

```bash
./bin/out/calculator
```

## Example

```text
========================================
        ASM SYSCALL CALCULATOR          
========================================

[1] Addition                            
[2] Subtraction                         
[3] Multiplication                      
[4] Division                            
[Q] Exit                                

Enter your first number: 1
Enter your second number: 2
Enter your operation: 3
Result: 2
Exit...
```

## Project Structure

```text
.
├── src/
│   └── main.asm
├── notes/
├── bin/
├── Makefile
├── LICENSE
└── README.md
```

## About

This is my first calculator written entirely with raw Linux system calls.

The project was created to practice x86-64 Assembly, Linux syscalls, manual input/output handling, string parsing, and integer formatting without using the C standard library.

## Roadmap

- [x] Calculator on libc (System V AMD64 ABI)
- [x] Calculator on raw Linux syscalls (no libc) 
- [ ] 16-bit BIOS calculator (boot sector)

## License

MIT

---

<p align="center">
  <img src="docs/cat.gif" width="800">
</p>