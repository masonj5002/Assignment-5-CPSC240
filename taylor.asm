;Mason Jennings
;masonj@csu.fullerton.edu
;11/26/2024

global taylor
extern printf ;deleteme
max_float_size equ 128

segment .data
samplemsg db "Hello from taylor!", 10, 0 ;deleteme DELETE ALL MESSAGES
samplefeedback db "The x value is: %f, the n value is %d", 10, 0 ;delemt
sampletop db "Hello from TOP!", 10, 0 ;deleteme DELETE ALL MESSAGES
float_valuen db "FLOAT VALUE TOP IS: %lf", 10, 0
float_valueb db "FLOAT VALUE BOTTOM IS: %lf", 10, 0
finalsoultion db "YOUR FINAL SOLUTION IS: %lf", 10, 0
regvalue db "%d", 10, 0
stringformat db "%s", 0
value_zero dq 0.0
value_one dq 1.0

segment .bss
top resq max_float_size
bottom resq max_float_size
;r12 is our 'n' value

segment .text
;****Program begins executing here****
taylor:     ;****
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
;'x' value in xmm9
mov r12, rdi     ;'n' value

mov rax, 1
mov rdi, samplefeedback
movsd xmm0, xmm9
mov rsi, r12
call printf

;FUNCATION BEGINS HERE:
;create a loop that cycles n times
;r12 is 'n'
xor r13, r13 ;iterator
movsd xmm15, [value_zero]   ;result
summation_loop:
    mov rax, 0
    mov rdi, stringformat
    mov rsi, samplemsg
    call printf

    ;Creating the numerator
    xor r14, r14 ;iterator
    movsd xmm10, [value_one]  ;top value
    top_loop:
        cmp r14, 0      ;for x^0
        je if_zero

        mulsd xmm10, xmm9 ;top_value *= x;

        top_resume:
        inc r14
        cmp r14, r13
        jg top_end
        jmp top_loop
    top_end:

    jmp if_zero_end
    if_zero:
        movsd xmm10, [value_one]
        jmp top_resume
    if_zero_end:

    ;TESTING
    movsd xmm0, xmm10         ; printf expects the float in xmm0
    mov rax, 1               ; Clear rax (no variadic arguments), 0
    mov rdi, float_valuen    ; Address of format string ("%lf\n")
    call printf              ; Call printf

    ;Creating the denominator
    movsd xmm11, [value_one]    ;result of bottom
    movsd xmm12, [value_one]    ;float counter (skipping zero)
    mov r14, 1                  ;iterator (skipping zero)
    ;TODO: Create if statement for 0! (which = 1)
    cmp r13, 0
    jne bottom_loop
    movsd xmm11, [value_one]
    jmp bottom_end

    bottom_loop: ;(ex: 4!)
        mulsd xmm11, xmm12

        addsd xmm12, [value_one]
        inc r14
        cmp r14, r13
        jg bottom_end
        jmp bottom_loop
    bottom_end:

    ;TESTING
    movsd xmm0, xmm11         ; printf expects the float in xmm0
    mov rax, 1               ; Clear rax (no variadic arguments), 0
    mov rdi, float_valueb    ; Address of format string ("%lf\n")
    call printf              ; Call printf

    movsd xmm14, xmm10 
    divsd xmm14, xmm11 ;top / bottom
    addsd xmm15, xmm14; += xmm14

    ;TESTING
    movsd xmm0, xmm15         ; printf expects the float in xmm0
    mov rax, 1               ; Clear rax (no variadic arguments), 0
    mov rdi, finalsoultion    ; Address of format string ("%lf\n")
    call printf              ; Call printf

    inc r13
    cmp r13, r12
    jg summation_end
    jmp summation_loop
summation_end:
;TESTING
movsd xmm0, xmm15         ; printf expects the float in xmm0
mov rax, 1               ; Clear rax (no variadic arguments), 0
mov rdi, finalsoultion    ; Address of format string ("%lf\n")
call printf              ; Call printf
movsd xmm0, xmm15
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