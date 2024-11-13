global series
extern printf
extern scanf

segment .data
    inputmessage db "Please enter a float number value for x: ", 0
    stringformat db "%s", 0

segment .bss
    ;empty for now

segment .text
    ;****Program begins executing here****
series:     ;****
    ;Back up registers
    ;PROLOG Backup GPRs (15 pushes)
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf
    ;GPRs are now in the stack
    ;flow begins here:
    ;Input message
    mov rax, 0
    mov rdi, stringformat
    mov rsi, inputmessage
    call printf

    ;Obtain float value
    

    ;flow ends here:
    ;restore GPRs to their original state
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rbp
    ; system stack has returned to initial state
ret
;** End of program **