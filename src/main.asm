global _start 

section .data 
    ; title
    title_msg:      db             '============================================', 10
                    db 27, "[32m", '          ASM SYSCALL CALCULATOR            ', 27, "[0m", 10
                    db             '============================================', 10
    len_title:      equ $ - title_msg

    ; menu
    menu_msg:       db 10, 27, "[36m",
                    db '[1] Addition                            ', 10
                    db '[2] Subtraction                         ', 10
                    db '[3] Multiplication                      ', 10
                    db '[4] Division                            ', 10
                    db '[Q] Exit                                ', 10
                    db 10, 27, "[0m"
    len_menu:       equ $ - menu_msg

    ; num1 
    prompt1_msg:    db 27, "[33m", 'Enter your first number: ', 27, "[0m"
    len_prompt1:    equ $ - prompt1_msg

    ; num2
    prompt2_msg:    db 27, "[33m", 'Enter your second number: ', 27, "[0m"
    len_prompt2:    equ $ - prompt2_msg

    ; operatiom
    prompt3_msg:    db 27, "[33m", 'Enter your operation: ', 27, "[0m"
    len_prompt3:    equ $ - prompt3_msg

    OP_ADD:         equ 1
    OP_SUB:         equ 2
    OP_MUL:         equ 3
    OP_DIV:         equ 4

    res_msg:        db 27, "[32m", 'Result: ', 27, "[0m"
    len_res:        equ $ - res_msg

    err_msg:        db 27, "[31m", 'Error: Cannot be divided by 0!', 27, "[0m", 10
    len_err:        equ $ - err_msg

    err_op_msg:     db 27, "[31m", "Error: Invalid operation!", 27, "[0m", 10
    len_err_op:     equ $ - err_op_msg

    exit_msg:       db 27, "[90m", 'Exit...', 27, "[0m", 10
    len_exit:       equ $ - exit_msg

    newline:        db 10

    ; clear screen
    clear_all:      db 0x1B, "[H", 0x1B, "[2J", 0x1B, "[3J"
    clear_len:      equ $ - clear_all

    delay_time:     dq 0, 10000000

section .bss
    buf_num1 resb 16
    buf_num2 resb 16
    buf_oper resb 16
    buf_out  resb 21 
    num1 resq 1
    num2 resq 1
    oper resq 1

section .text

_start:
    ; clear screen 
    call clear_screen

    ; title
    mov r8, title_msg
    mov r9, len_title
    call animate_title

    ; menu
    mov rsi, menu_msg
    mov rdx, len_menu
    call print_str

    ; num1
    ; print prompt1
    mov rsi, prompt1_msg
    mov rdx, len_prompt1
    call print_str

    ; input num1 
    mov rsi, buf_num1
    call input_str
    call check_exit

    mov rsi, buf_num1
    call str_to_int
    mov [num1], rax

    ; num2
    ; print prompt2
    mov rsi, prompt2_msg
    mov rdx, len_prompt2
    call print_str

    ; input num2 
    mov rsi, buf_num2
    call input_str
    call check_exit

    mov rsi, buf_num2
    call str_to_int
    mov [num2], rax

    ; oper
    ; print prompt3
    mov rsi, prompt3_msg
    mov rdx, len_prompt3
    call print_str

    ; input oper
    mov rsi, buf_oper
    call input_str
    call check_exit
    
    mov rsi, buf_oper
    call str_to_int
    mov [oper], rax

    ; switch
    mov rax, [oper]
    cmp rax, OP_ADD
    je .case_add
    cmp rax, OP_SUB
    je .case_sub
    cmp rax, OP_MUL
    je .case_mul
    cmp rax, OP_DIV
    je .case_div
    
    ; check
    mov rsi, err_op_msg
    mov rdx, len_err_op
    call print_str

    ; exit
    jmp exit

; +
.case_add:
    mov rax, [num1]
    add rax, [num2]
    jmp .print_res

; -
.case_sub:
    mov rax, [num1]
    sub rax, [num2]
    jmp .print_res

; *
.case_mul:
    mov rax, [num1]
    imul rax, [num2]
    jmp .print_res

; /
.case_div:
    push rbx
    mov rbx, [num2]
    cmp rbx, 0
    je .err_div0
    mov rax, [num1]
    cqo
    idiv rbx
    pop rbx
    jmp .print_res

.err_div0:
    pop rbx
    mov rsi, err_msg
    mov rdx, len_err
    call print_str
    jmp exit

.print_res:
    push rax 
    mov rsi, res_msg
    mov rdx, len_res
    call print_str
    pop rax
    call int_to_print
    mov rsi, newline
    mov rdx, 1
    call print_str
    jmp exit

animate_title:
.loop:
    cmp r9, 0             
    je .done
    mov rsi, r8           
    mov rdx, 1              
    call print_str
    mov rax, 35      
    mov rdi, delay_time   
    xor rsi, rsi          
    syscall
    inc r8              
    dec r9                 
    jmp .loop        
.done:
    ret 

clear_screen:
    mov rsi, clear_all
    mov rdx, clear_len
    call print_str
    ret

input_str:
    mov rax, 0
    mov rdi, 0 
    mov rdx, 16 
    syscall
    ret

print_str:
    mov rax, 1
    mov rdi, 1
    syscall
    ret

check_exit:
    cmp byte [rsi], 'q'
    je exit
    cmp byte [rsi], 'Q'
    je exit
    ret

exit:
    mov rsi, exit_msg
    mov rdx, len_exit
    call print_str
    mov rax, 60 
    mov rdi, 0
    syscall

; str to int
str_to_int:
    xor rax, rax
    xor rcx, rcx
    xor r8, r8
    cmp byte [rsi], '-'
    jne .loop
    mov r8, 1
    inc rcx
.loop:
    movzx rdx, byte [rsi + rcx]
    cmp dl, 10  
    je .done
    cmp dl, 0
    je .done
    cmp dl, '0'
    jb .done
    cmp dl, '9'
    ja .done
    sub dl, '0'
    imul rax, 10
    add rax, rdx
    inc rcx
    jmp .loop
.done:
    test r8, r8
    jz .positive
    neg rax
.positive:
    ret

; int to print
int_to_print:
    push rbx
    mov rbx, 10
    mov rsi, buf_out + 20
    mov byte [rsi], 0
    test rax, rax
    jge .positive
    neg rax   
    mov r8b, 1        
    jmp .check_zero
.positive:
    xor r8d, r8d
.check_zero:
    test rax, rax
    jnz .loop
    dec rsi
    mov byte [rsi], '0'
    jmp .sign
.loop:
    xor rdx, rdx
    div rbx
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz .loop
.sign:
    test r8b, r8b
    jz .print
    dec rsi
    mov byte [rsi], '-'
.print:
    mov rdx, buf_out + 20
    sub rdx, rsi
    call print_str
    pop rbx
    ret