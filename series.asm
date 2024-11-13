; Mason Jennings
; masonj@csu.fullerton.edu

global series
extern taylor
extern printf
extern scanf
max_float_size equ 128

segment .data
    inputmessage db "Please enter a float number value for x: ", 0
    sampleoutput db "YOU ENTERED: %f", 10, 0 ;DELETE ME
    time1 db "The time on the clock is now _______ tics and taylor has been called.", 10, 0
    thankyoumsg db "Thank you for waiting", 10, 0
    stringformat db "%s", 0
    floatformat db "%lf", 0

segment .bss
    float_value resq max_float_size

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
    ;input message
    mov rax, 0
    mov rdi, stringformat
    mov rsi, inputmessage
    call printf

    ;obtain floating-point value
    mov qword rax, 0
    mov rdi, floatformat
    mov rsi, float_value
    call scanf
    movsd xmm0, [float_value]
        
    ;RECALLING FLOATING pt. VALUES:
    mov rax, 1
    mov rdi, sampleoutput
    call printf

    mov rax, 0
    call taylor

    ;"the time on the clock is now 1234567 tics and taylor has been called"

    mov rax, 0
    mov rdi, stringformat
    mov rsi, thankyoumsg
    call printf


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