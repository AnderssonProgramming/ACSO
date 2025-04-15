@ Lab5b - Versión compatible con ARMv6 (Raspberry Pi original)
@ Reemplaza UDIV con división por sustracción

.data
fmtin:      .asciz "%d"
fmtout:     .asciz "%d\n"

.balign 4
numCasos:   .word 0
pasajeros:  .skip 20      @ 5 enteros (Be, Ing, Nor, Ire, Fra)
mcd:        .word 0
aviones:    .skip 20      @ 5 enteros
total:      .word 0

.text
.global main
.global printf
.global scanf

@ Función GCD (Máximo Común Divisor)
gcd:
    cmp r0, r1
    beq gcd_end
    bgt gcd_sub
    sub r1, r1, r0
    b gcd
gcd_sub:
    sub r0, r0, r1
    b gcd
gcd_end:
    bx lr

@ Función división (reemplazo para UDIV)
divide:
    mov r3, #0
divide_loop:
    cmp r1, r2
    blt divide_end
    sub r1, r1, r2
    add r3, r3, #1
    b divide_loop
divide_end:
    mov r0, r3    @ Cociente en r0
    bx lr

main:
    push {r4-r10, lr}

    @ Leer número de casos
    ldr r0, =fmtin
    ldr r1, =numCasos
    bl scanf

    ldr r1, =numCasos
    ldr r2, [r1]
    cmp r2, #0
    beq end

caso_loop:
    @ Leer 5 pasajeros
    ldr r4, =pasajeros
    mov r5, #0

leer_loop:
    cmp r5, #5
    beq calcular_mcd
    ldr r0, =fmtin
    add r1, r4, r5, LSL #2
    bl scanf
    add r5, r5, #1
    b leer_loop

calcular_mcd:
    ldr r0, [r4]       @ r0 = pasajeros[0]
    mov r5, #1
mcd_loop:
    cmp r5, #5
    beq guardar_mcd
    add r6, r4, r5, LSL #2
    ldr r1, [r6]       @ r1 = pasajeros[i]
    bl gcd
    add r5, r5, #1
    b mcd_loop

guardar_mcd:
    ldr r1, =mcd
    str r0, [r1]

    @ Calcular aviones por país (usando división por sustracción)
    mov r5, #0
    mov r6, #0         @ r6 = total aviones
    ldr r7, =aviones
    ldr r8, =pasajeros
    ldr r9, =mcd
    ldr r10, [r9]      @ pasajeros por avión

calc_loop:
    cmp r5, #5
    beq imprimir
    add r0, r8, r5, LSL #2
    ldr r1, [r0]       @ pasajeros[i]
    mov r2, r10
    bl divide          @ r0 = pasajeros[i] / mcd
    add r6, r6, r0
    add r1, r7, r5, LSL #2
    str r0, [r1]       @ almacenar en aviones[i]
    add r5, r5, #1
    b calc_loop

imprimir:
    @ imprimir mcd
    ldr r0, =fmtout
    ldr r1, =mcd
    ldr r1, [r1]
    bl printf

    @ imprimir aviones por país
    mov r5, #0
    ldr r4, =aviones
imp_loop:
    cmp r5, #5
    beq imp_total
    ldr r0, =fmtout
    add r1, r4, r5, LSL #2
    ldr r1, [r1]
    bl printf
    add r5, r5, #1
    b imp_loop

imp_total:
    @ imprimir total
    ldr r0, =fmtout
    mov r1, r6
    bl printf

    @ Decrementar casos
    ldr r1, =numCasos
    ldr r2, [r1]
    sub r2, r2, #1
    str r2, [r1]
    cmp r2, #0
    bgt caso_loop

end:
    mov r0, #0
    pop {r4-r10, pc}