section .bss
    buffer resb 11 ; Buffer to store the ASCII representation (up to 10 digits + null terminator)

section .text
    global _start

_start:
    ; Read the input integer from standard input (stdin)
    mov rdi, 0       ; File descriptor 0 (stdin)
    mov rsi, buffer  ; Buffer address to store the input
    mov rdx, 11      ; Maximum number of bytes to read (including null terminator)
    mov rax, 0       ; System call number for sys_read
    syscall

    ; Find the length of the input string (excluding the null terminator)
    mov rcx, 0       ; Counter for string length
.loop:
    mov al, byte [rsi + rcx]
    cmp al, 0        ; Check for null terminator
    je .found_end
    inc rcx
    cmp rcx, 10      ; Maximum input length of 10 digits
    jnz .loop

.found_end:
    ; Convert the ASCII string to integer
    mov rbx, 0       ; Result in RBX
    mov rdx, 1       ; Multiplier (1, 10, 100, 1000, ...)
.convert_loop:
    movzx rax, byte [rsi + rcx - 1]  ; Load the ASCII character
    sub rax, '0'                     ; Convert from ASCII to integer ('0' -> 0, '1' -> 1, ..., '9' -> 9)
    imul rbx, rax                    ; Multiply result by the multiplier
    dec rcx
    test rcx, rcx                    ; Check if we reached the beginning of the string
    jnz .convert_loop

    ; At this point, the integer result is stored in RBX

    ; Convert the integer back to ASCII representation
    mov rsi, buffer + 10  ; Point to the end of the buffer (right before the null terminator)
    mov byte [rsi], 0     ; Null-terminate the string

    ; Handle the special case of input 0
    test rbx, rbx
    jnz .not_zero

    ; If the input is 0, just write '0' to the buffer
    mov byte [rsi - 1], '0'
    jmp .done

.not_zero:
    ; Loop to convert the integer to ASCII (backward direction)
    .convert_back:
    mov rax, rbx
    xor rdx, rdx
    mov rbx, 10
    div rbx            ; Divide RAX by 10, quotient in RAX, remainder in RDX
    add dl, '0'        ; Convert remainder to ASCII
    dec rsi
    mov byte [rsi], dl ; Store ASCII digit in buffer
    test rax, rax
    jnz .convert_back  ; Repeat until quotient becomes 0

.done:
    ; Now the ASCII representation of the integer is stored in the 'buffer'.
    ; You can use the debugger to inspect the contents of the 'buffer'.

    ; Terminate the program
    mov rax, 60         ; System call number for sys_exit
    xor rdi, rdi        ; Return 0 status
    syscall