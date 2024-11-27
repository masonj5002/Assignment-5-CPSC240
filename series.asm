; Mason Jennings
; masonj@csu.fullerton.edu

global series
extern taylor
extern printf
extern scanf
max_float_size equ 128
max_int_size equ 128

segment .data
input_x_message db "Please enter a float number value for x: ", 0
input_n_message db "Please enter the number of terms to include in the Taylor sum: ", 0
thankyoumsg db "Thank you for waiting", 10, 0
computedoutput db "The computed approximation of e^x is %lf with precision of 8 digits right of the point.", 10, 0
goodbyemsg db "Thank you for using the Eyere expopnentional calculator", 10, 0
goodbyemsgtwo db "Please return another day. The computed value will be set to caller functions.", 10, 0
stringformat db "%s", 0
floatformat db "%lf", 0
intformat db "%d", 0

segment .bss
float_value resq max_float_size
int_value resq max_int_size

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
;obtain 'x'
mov rax, 0
mov rdi, stringformat
mov rsi, input_x_message
call printf

mov qword rax, 0
mov rdi, floatformat
mov rsi, float_value
call scanf
movsd xmm0, [float_value]
movsd xmm9, xmm0

;obtain 'n'
mov rax, 0
mov rdi, stringformat
mov rsi, input_n_message
call printf

mov qword rax, 0
mov rdi, intformat
mov rsi, int_value
call scanf

mov rax, 0
mov rdi, [int_value]
call taylor
movsd xmm15, xmm0

mov rax, 0
mov rdi, stringformat
mov rsi, thankyoumsg
call printf

movsd xmm0, xmm15
mov rax, 1
mov rdi, computedoutput
call printf

mov rax, 0
mov rdi, goodbyemsg
call printf

mov rax, 0
mov rdi, goodbyemsgtwo
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