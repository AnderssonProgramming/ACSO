.data

.balign 4
a:      .word 0
b:      .word 0
c:      .word 0
x:      .word 0
res:    .word 0

input:  .asciz "%d"
output: .asciz "%d\n"

.text

.global main
.global scanf
.global printf

.func main
main:
    PUSH {LR}

    @ Leer a
    LDR R0, =input
    LDR R1, =a
    BL scanf

    @ Leer b
    LDR R0, =input
    LDR R1, =b
    BL scanf

    @ Leer c
    LDR R0, =input
    LDR R1, =c
    BL scanf

    @ Leer x
    LDR R0, =input
    LDR R1, =x
    BL scanf

    @ Calcular ax^2 + bx + c

    LDR R0, =a
    LDR R1, [R0]      @ R1 = a

    LDR R0, =b
    LDR R2, [R0]      @ R2 = b

    LDR R0, =c
    LDR R3, [R0]      @ R3 = c

    LDR R0, =x
    LDR R4, [R0]      @ R4 = x

    MUL R5, R4, R4    @ R5 = x^2
    MUL R6, R5, R1    @ R6 = a * x^2

    MUL R7, R4, R2    @ R7 = b * x

    ADD R8, R6, R7    @ R8 = a*x^2 + b*x
    ADD R8, R8, R3    @ R8 = a*x^2 + b*x + c

    LDR R0, =res
    STR R8, [R0]

    @ Imprimir resultado
    LDR R0, =output
    LDR R1, =res
    LDR R1, [R1]
    BL printf

    POP {LR}
    MOV R0, #0
    BX LR
.endfunc
