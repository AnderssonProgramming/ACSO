/** Proyecto 5 | Daniel Antonio Santanillla | pro05.s
*   Escriba un programa en lenguaje ensamblador de ARM que, 
*   utilizando reales, lea las coordenadas de 3 puntos
*   en el plano cartesiano que corresponden a los vertices 
*   de un triangulo, y clasifique al triangulo de acuerdo a los
*   angulos.
*/
.data

.balign 4
puntoax:    .float 0f0.0

puntoay:    .float 0f0.0

puntobx:    .float 0f0.0

puntoby:    .float 0f0.0

puntocx:    .float 0f0.0

puntocy:    .float 0f0.0

anguloA:    .float 0f0.0

anguloB:    .float 0f0.0

anguloC:    .float 0f0.0

zero:       .float 0f0.0

.balign 4
precision:  .float 0f0.000001

.balign 4
casos:      .word 0

return:     .word 0

retcalang:  .word 0

retclasif:  .word 0

.balign 4
input:      .asciz "%d"

.balign	4
inputdata:  .asciz "%f %f %f"

.balign	4
rectangulo: .asciz "rectangulo\n"

.balign	4
obtusangulo:.asciz "obtusangulo\n"

.balign	4
acutangulo: .asciz "acutangulo\n"

.text

.global main
.global scanf
.global printf

.func main
main:
    LDR R0, =return
    STR LR, [R0]
    LDR R0, =input  @ input casos
    LDR R1, =casos
    BL scanf
loop:
    LDR R0, =casos
    LDR R0, [R0]
    CMP R0, #0
    BEQ endloop
    SUB R0, R0, #1  @ casos - 1
    LDR R1, =casos
    STR R0, [R1]
    LDR R0, =inputdata
    LDR R1, =puntoax
    LDR R2, =puntoay
    LDR R3, =puntobx
    BL scanf
    LDR R0, =inputdata
    LDR R1, =puntoby
    LDR R2, =puntocx
    LDR R3, =puntocy
    BL scanf
    BL calanguloA
    BL calanguloB
    BL calanguloC
    BL clasificacion
    B loop
endloop:
    LDR R0, =return
    LDR LR, [R0]
    MOV R0, #0
    BX LR
.endfunc

.func calanguloA
calanguloA:
    LDR R0, =retcalang
    STR LR, [R0]
    LDR R0, =puntoax
    VLDR.f32    S0, [R0]
    LDR R0, =puntoay
    VLDR.f32    S1, [R0]
    LDR R0, =puntobx
    VLDR.f32    S2, [R0]
    LDR R0, =puntoby
    VLDR.f32    S3, [R0]
    LDR R0, =puntocx
    VLDR.f32    S4, [R0]
    LDR R0, =puntocy
    VLDR.f32    S5, [R0]
    @ vector AB
    VSUB.f32    S6, S2, S0  @ vi
    VSUB.f32    S7, S3, S1  @ vj
    @ vector AC
    VSUB.f32    S8, S4, S0  @ ui
    VSUB.f32    S9, S5, S1  @ uj
    @ AB * AC
    VMUL.f32    S0, S6, S8  @ vi * ui 
    VMUL.f32    S1, S7, S9  @ vj * uj
    VADD.f32    S5, S0, S1  @ AB * AC
    @ |AB| * |AC|
    VMUL.f32    S0, S6, S6  @ vi^2
    VMUL.f32    S1, S7, S7  @ vj^2
    VADD.f32    S2, S0, S1  @ vi^2 + vj^2
    VSQRT.f32   S4, S2      @ sqrt(vi^2 + vj^2)
    VMUL.f32    S0, S8, S8  @ ui^2
    VMUL.f32    S1, S9, S9  @ uj^2
    VADD.f32    S2, S0, S1  @ ui^2 + uj^2
    VSQRT.f32   S3, S2      @ sqrt(ui^2 + uj^2)
    VMUL.f32    S2, S3, S4  @ |AB| * |AC|
    @ cos(a) = (AB * AC)/(|AB| * |AC|)
    VDIV.f32    S1, S5, S2
    LDR R0, =anguloA
    VSTR        S1, [R0]
    LDR R0, =retcalang
    LDR LR, [R0]
    BX LR
.endfunc

.func calanguloB
calanguloB:
    LDR R0, =retcalang
    STR LR, [R0]
    LDR R0, =puntoax
    VLDR.f32    S0, [R0]
    LDR R0, =puntoay
    VLDR.f32    S1, [R0]
    LDR R0, =puntobx
    VLDR.f32    S2, [R0]
    LDR R0, =puntoby
    VLDR.f32    S3, [R0]
    LDR R0, =puntocx
    VLDR.f32    S4, [R0]
    LDR R0, =puntocy
    VLDR.f32    S5, [R0]
    @ vector BA
    VSUB.f32    S6, S0, S2  @ vi
    VSUB.f32    S7, S1, S3  @ vj
    @ vector BC
    VSUB.f32    S8, S4, S2  @ ui
    VSUB.f32    S9, S5, S3  @ uj
    @ BA * BC
    VMUL.f32    S0, S6, S8  @ vi * ui 
    VMUL.f32    S1, S7, S9  @ vj * uj
    VADD.f32    S5, S0, S1  @ BA * BC
    @ |BA| * |BC|
    VMUL.f32    S0, S6, S6  @ vi^2
    VMUL.f32    S1, S7, S7  @ vj^2
    VADD.f32    S2, S0, S1  @ vi^2 + vj^2
    VSQRT.f32   S4, S2      @ sqrt(vi^2 + vj^2)
    VMUL.f32    S0, S8, S8  @ ui^2
    VMUL.f32    S1, S9, S9  @ uj^2
    VADD.f32    S2, S0, S1  @ ui^2 + uj^2
    VSQRT.f32   S3, S2      @ sqrt(ui^2 + uj^2)
    VMUL.f32    S2, S3, S4  @ |BA| * |BC|
    @ cos(a) = (BA * BC)/(|BA| * |BC|)
    VDIV.f32    S1, S5, S2
    LDR R0, =anguloB
    VSTR        S1, [R0]
    LDR R0, =retcalang
    LDR LR, [R0]
    BX LR
.endfunc

.func calanguloC
calanguloC:
    LDR R0, =retcalang
    STR LR, [R0]
    LDR R0, =puntoax
    VLDR.f32    S0, [R0]
    LDR R0, =puntoay
    VLDR.f32    S1, [R0]
    LDR R0, =puntobx
    VLDR.f32    S2, [R0]
    LDR R0, =puntoby
    VLDR.f32    S3, [R0]
    LDR R0, =puntocx
    VLDR.f32    S4, [R0]
    LDR R0, =puntocy
    VLDR.f32    S5, [R0]
    @ vector CA
    VSUB.f32    S6, S0, S4  @ vi
    VSUB.f32    S7, S1, S5  @ vj
    @ vector CB
    VSUB.f32    S8, S2, S4  @ ui
    VSUB.f32    S9, S3, S5  @ uj
    @ CA * CB
    VMUL.f32    S0, S6, S8  @ vi * ui 
    VMUL.f32    S1, S7, S9  @ vj * uj
    VADD.f32    S5, S0, S1  @ CA * CB
    @ |CA| * |CB|
    VMUL.f32    S0, S6, S6  @ vi^2
    VMUL.f32    S1, S7, S7  @ vj^2
    VADD.f32    S2, S0, S1  @ vi^2 + vj^2
    VSQRT.f32   S4, S2      @ sqrt(vi^2 + vj^2)
    VMUL.f32    S0, S8, S8  @ ui^2
    VMUL.f32    S1, S9, S9  @ uj^2
    VADD.f32    S2, S0, S1  @ ui^2 + uj^2
    VSQRT.f32   S3, S2      @ sqrt(ui^2 + uj^2)
    VMUL.f32    S2, S3, S4  @ |CA| * |CB|
    @ cos(a) = (CA * CB)/(|CA| * |CB|)
    VDIV.f32    S1, S5, S2
    LDR R0, =anguloC
    VSTR        S1, [R0]
    LDR R0, =retcalang
    LDR LR, [R0]
    BX LR
.endfunc

.func clasificacion
clasificacion:
    LDR R0, =retclasif
    STR LR, [R0]
    LDR R0, =anguloA
    VLDR.f32    S0, [R0]
    LDR R0, =anguloB
    VLDR.f32    S1, [R0]
    LDR R0, =anguloC
    VLDR.f32    S2, [R0]
    LDR R0, =zero
    VLDR.f32    S3, [R0]
condespecial:
    VCMP.f32   S0, S3
    VMRS       APSR_nzcv, FPSCR
    BEQ esRectangulo
    VCMP.f32   S1, S3
    VMRS       APSR_nzcv, FPSCR
    BEQ esRectangulo
    VCMP.f32   S2, S3
    VMRS       APSR_nzcv, FPSCR
    BEQ esRectangulo
cond0:
    VCMP.f32   S0, S3
    VMRS       APSR_nzcv, FPSCR
    BLT esObtusangulo
    B   cond1
cond1:
    VCMP.f32   S1, S3
    VMRS       APSR_nzcv, FPSCR
    BLT esObtusangulo
    B   cond2
cond2:
    VCMP.f32   S2, S3
    VMRS       APSR_nzcv, FPSCR
    BLT esObtusangulo
    B   esAcutangulo
esRectangulo:
    LDR R0, =rectangulo
    BL printf
    B endclasificacion
esAcutangulo:
    LDR R0, =acutangulo
    BL printf
    B endclasificacion
esObtusangulo:
    LDR R0, =obtusangulo
    BL printf
    B endclasificacion
endclasificacion:
    LDR R0, =retclasif
    LDR LR, [R0]
    BX LR
.endfunc

.end

