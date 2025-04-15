/** Laboratorio 9 | Daniel Antonio Santanillla | punto 9b
*   Escribir un programa en lenguaje ensamblador de ARM
*   que calcule la fraccion egipcia de un numero racional positivo
*/
.data

.balign 4
casos:  .word 0

valMCD: .word 0

retMCD: .word 0

retDiv: .word 0

retMod: .word 0

retEgi: .word 0

retNeD: .word 0

retNeN: .word 0

return: .word 0

numerador:  .word 0

cociente:   .word 0

residuo:    .word 0

egipcio:    .word 0

denominador:    .word 0

.balign	4
input:  .asciz "%d"

.balign	4
output: .asciz "%d\n"

.text

.global main
.global scanf
.global printf

.func main
main:
    LDR R10, =return
    STR LR, [R10]
    LDR R0, =input
    LDR R1, =casos
    BL scanf
loop:
    LDR R0, =casos
    LDR R0, [R0]
    CMP R0, #0
    BEQ endLoop
    SUB R0, R0, #1
    LDR R1, =casos
    STR R0, [R1]
    LDR R0, =input
    LDR R1, =numerador
    BL scanf
    LDR R0, =input
    LDR R1, =denominador
    BL scanf
    LDR R1, =residuo
    LDR R0, [R1]
    MOV R0, #1
    STR R0, [R1]
    BL fracEgipcia
    BAL loop
endLoop:
    LDR LR, =return
    LDR LR, [LR]
    MOV R0, #0
    BX LR
.endfunc

/* Funcion que realiza la fraccion egipcia para los numeros dados.*/
.func fracEgipcia
fracEgipcia:
    LDR R10, =retEgi
    STR LR, [R10]
fracLoop:
    LDR R0, =residuo
    LDR R0, [R0]
    CMP R0, #0
    BEQ endFracLoop

    LDR R0, =numerador      @ MCD entre el numerador y denominador
    LDR R0, [R0]
    LDR R1, =denominador
    LDR R1, [R1]
    BL mcd

    LDR R0, =numerador      @ simplificar el denominador
    LDR R0, [R0]
    LDR R1, =valMCD
    LDR R1, [R1]
    BL div
    LDR R0, =cociente
    LDR R0, [R0]
    LDR R1, =numerador
    STR R0, [R1]
    
    LDR R0, =denominador    @ simplificar el denominador
    LDR R0, [R0]
    LDR R1, =valMCD
    LDR R1, [R1]
    BL div
    LDR R0, =cociente
    LDR R0, [R0]
    LDR R1, =denominador
    STR R0, [R1]

    LDR R0, =denominador
    LDR R0, [R0]
    LDR R1, =numerador
    LDR R1, [R1]
    BL mod
    LDR R0, =denominador
    LDR R0, [R0]
    LDR R1, =numerador
    LDR R1, [R1]
    BL div

    LDR R0, =residuo
    LDR R0, [R0]
    CMP R0, #0
    BEQ endFracLoop
    LDR R0, =egipcio
    LDR R0, [R0]
    LDR R1, =cociente
    LDR R1, [R1]
    ADD R0, R1, #1
    LDR R2, =egipcio
    STR R0, [R2]

    LDR R0, =output
    LDR R1, =egipcio
    LDR R1, [R1]
    BL printf

    LDR R0, =numerador      @ nuevo numerador
    LDR R0, [R0]
    LDR R1, =denominador
    LDR R1, [R1]
    LDR R2, =egipcio
    LDR R2, [R2]
    BL new_nume

    LDR R0, =denominador    @ nuevo denominador
    LDR R0, [R0]
    LDR R1, =egipcio
    LDR R1, [R1]
    BL new_denom

    B fracLoop


endFracLoop:
    LDR R0, =output
    LDR R1, =cociente
    LDR R1, [R1]
    BL printf
    LDR R0, =output
    MOV R1, #0
    BL printf
    LDR LR, =retEgi
    LDR LR, [LR]
.endfunc

/* Funcion que calcula el nuevo numerador de la fraccion r 
* input: R0 = a; R1 = b; R2 = d
* output: R3 = numerador
*/
.func new_nume
new_nume:
    LDR R10, =retNeN
    STR LR, [R10]
    MUL R3, R0, R2  
    SUB R3, R3, R1  @ ad - b
    LDR R0, =numerador
    STR R3, [R0]
    LDR LR, =retNeN
    LDR LR, [LR]
    BX LR
.endfunc

/* Funcion que calcula el nuevo denominador de la fraccion r 
* input: R0 = a; R1 = b
* output: R2 = denominador
*/
.func new_denom
new_denom:
    LDR R10, =retNeD
    STR LR, [R10]
    MUL R2, R0, R1  @ bd
    LDR R0, =denominador
    STR R2, [R0]
    LDR LR, =retNeD
    LDR LR, [LR]
    BX LR
.endfunc

/* Funcion que calcula el maximo comun divisor entre dos numeros 
* MCD(a, b) = valMCD
* input: R0 = a; R1 = b
* output: R2 = valMCD
*/
.func mcd
mcd:
    LDR R10, =retMCD
    STR LR, [R10]
mcdLoop:
    CMP R1, #0
    BEQ mcdEndLoop
    MOV R3, R1
    BL mod
    MOV R0, R3
    LDR R5, =residuo
    LDR R1, [R5]
    BL mcdLoop
mcdEndLoop:
    LDR R2, =valMCD
    STR R0, [R2]
    LDR LR, =retMCD
    LDR LR, [LR]
    BX LR
.endfunc

/* Funcion que calcula el cociente entre dos numeros 
* div(a, b) = cociente
* input: R0 = a; R1 = b
* output: R2 = cociente
*/
.func div
div:
    LDR R10, =retDiv
    STR LR, [R10]
    MOV R2, #0
divLoop:
    SUB R0, R0, R1  @ a = a - b
    CMP R0, #0
    BLE divEndLoop
    ADD R2, R2, #1  @ cociente = cociente + 1
    BL divLoop
divEndLoop:
    CMP R0, #0
    BNE divElse
    ADD R2, R2, #1
divElse:
    LDR R0, =cociente
    STR R2, [R0]
    LDR LR, =retDiv
    LDR LR, [LR]
    BX LR
.endfunc

/* Funcion que calcula el residuo entre dos numeros (mod)
* mod(a, b) = residuo
* input: R0 = a; R1 = b
* output: R2 = residuo
*/
.func mod 
mod:
    LDR R10, =retMod
    STR LR, [R10]
    MOV R2, #0
modLoop:
    MOV R2, R0
    SUB R0, R0, R1  @ a = a - b
    CMP R0, #0
    BLE modEndLoop
    MOV R2, R0
    BL modLoop
modEndLoop:
    CMP R0, #0
    BNE modElse
    MOV R2, #0
modElse:
    LDR R0, =residuo
    STR R2, [R0]
    LDR LR, =retMod
    LDR LR, [LR]
    BX LR
.endfunc

.end