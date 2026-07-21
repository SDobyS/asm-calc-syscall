# ASM Syscall Calculator

<p align="center">

<img src="https://img.shields.io/badge/Assembly-x86--64-blue">
<img src="https://img.shields.io/badge/NASM-2.x-success">
<img src="https://img.shields.io/badge/Linux-Syscalls-red">
<img src="https://img.shields.io/badge/Linux-x86__64-black?logo=linux">
<img src="https://img.shields.io/badge/License-MIT-yellow">

</p>

🇷🇺 Русский | 🇬🇧 [English](README.md)

Простой консольный калькулятор, написанный на x86-64 Assembly с использованием только системных вызовов Linux (без libc).

## Возможности

- Сложение целых чисел
- Вычитание целых чисел
- Умножение целых чисел
- Деление целых чисел
- Обработка деления на ноль
- Обработка неверной операции
- Ручное преобразование строки в число
- Ручное преобразование числа в строку
- Использование системных вызовов Linux (`read`, `write`, `exit`)
- Без зависимости от libc
- Поддержка ANSI-цветов для элементов интерфейса
- Очистка экрана при запуске
- Выход по нажатию 'q' в любом поле ввода
- Синтаксис NASM

## Требования

- Linux
- NASM
- GNU LD
- GNU Make

## Сборка

```bash
make
```

Ручная сборка:

```bash
nasm -f elf64 src/main.asm -o bin/obj/main.o
ld bin/obj/main.o -o bin/out/calculator
```

## Запуск

```bash
make run
```

или

```bash
./bin/out/calculator
```

## Пример работы

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

## Структура проекта

```text
.
├── src/
│   └── main.asm
├── notes/
├── bin/
├── Makefile
├── LICENSE
├── README.md
└── README_RU.md
```

## О проекте

Это мой первый калькулятор, полностью написанный с использованием системных вызовов Linux.

Проект создан для практики программирования на x86-64 Assembly, изучения Linux syscalls, ручной работы с вводом/выводом, преобразования строк в числа и чисел в строки без использования стандартной библиотеки C.

## Планы

- [x] Калькулятор на libc (System V AMD64 ABI)
- [x] Калькулятор на Linux syscalls (no libc) 
- [ ] 16-битный BIOS-калькулятор (boot sector)

## Лицензия

MIT

---

<p align="center">
  <img src="docs/cat.gif" width="800">
</p>