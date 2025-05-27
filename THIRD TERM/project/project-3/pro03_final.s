/** Proyecto 03 | Andersson David Sánchez Méndez
*   Escriba un programa en lenguaje ensamblador de ARM que, 
*   utilizando reales, lea las coordenadas de 3 puntos
*   en el plano cartesiano que corresponden a los vértices de un triángulo, 
*   calcule el perímetro, el área, y clasifique al triángulo de acuerdo a los lados y ángulos.
*/
.data

.balign 4
puntoax:    .float 0f0.0

puntoay:    .float 0f0.0

puntobx:    .float 0f0.0

puntoby:    .float 0f0.0

puntocx:    .float 0f0.0

puntocy:    .float 0f0.0

segmenta:   .float 0f0.0

segmentb:   .float 0f0.0

segmentc:   .float 0f0.0

valArea:    .float 0f0.0

valPerim:   .float 0f0.0

anguloA:    .float 0f0.0

anguloB:    .float 0f0.0

anguloC:    .float 0f0.0

zero:       .float 0f0.0

.balign 4
two:        .float 0f2.0

.balign 4
precision:  .float 0f0.000001

.balign 4
casos:      .word 0

return:     .word 0

retcalseg:  .word 0

retarea:    .word 0

retperim:   .word 0

retclasif:  .word 0

retcalang:  .word 0

retfin:     .word 0

.balign 4
input:      .asciz "%d"

.balign	4
inputdata:  .asciz "%f %f %f"

.balign	4
output:     .asciz "%f "

.balign	4
escaleno:   .asciz "escaleno\n"

.balign	4
isoceles:   .asciz "isoceles\n"

.balign	4
equilatero: .asciz "equilatero\n"

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
    BL calsegmentos
    BL perimetro
    BL triangarea
    BL printrespuesta
    BL clasificacion_lados
    BL calanguloA
    BL calanguloB
    BL calanguloC
    BL clasificacion_angulos
    B loop
endloop:
    LDR R0, =return
    LDR LR, [R0]
    MOV R0, #0
    BX LR
.endfunc

// Functions from pro03.s
.func calsegmentos
calsegmentos:
    LDR R0, =retcalseg
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
    VSUB.f32    S6, S2, S0  @ segmento c:  d(A,B)
    VMUL.f32    S6, S6, S6
    VSUB.f32    S7, S3, S1
    VMUL.f32    S7, S7, S7
    VADD.f32    S8, S6, S7
    VSQRT.f32   S8, S8
    LDR R0, =segmenta
    VSTR        S8, [R0]
    VSUB.f32    S6, S4, S0  @ segmento b:  d(A,C)
    VMUL.f32    S6, S6, S6
    VSUB.f32    S7, S5, S1
    VMUL.f32    S7, S7, S7
    VADD.f32    S8, S6, S7
    VSQRT.f32   S8, S8
    LDR R0, =segmentb
    VSTR        S8, [R0]
    VSUB.f32    S6, S4, S2  @ segmento a:  d(B,C)
    VMUL.f32    S6, S6, S6
    VSUB.f32    S7, S5, S3
    VMUL.f32    S7, S7, S7
    VADD.f32    S8, S6, S7
    VSQRT.f32   S8, S8
    LDR R0, =segmentc
    VSTR        S8, [R0]
    LDR R0, =retcalseg
    LDR LR, [R0]
    BX LR
.endfunc

.func perimetro
perimetro:
    LDR R0, =retperim
    STR LR, [R0]
    LDR R0, =segmenta
    VLDR.f32    S0, [R0]
    LDR R0, =segmentb
    VLDR.f32    S1, [R0]
    LDR R0, =segmentc
    VLDR.f32    S2, [R0]
    VADD.f32    S3, S0, S1
    VADD.f32    S3, S3, S2  @ perimetro = a + b + c
    LDR R0, =valPerim
    VSTR        S3, [R0]
    LDR R0, =retperim
    LDR LR, [R0]
    BX LR
.endfunc

.func triangarea
triangarea:
    LDR R0, =retarea
    STR LR, [R0]
    LDR R0, =segmenta
    VLDR.f32    S0, [R0]
    LDR R0, =segmentb
    VLDR.f32    S1, [R0]
    LDR R0, =segmentc
    VLDR.f32    S2, [R0]
    LDR R0, =valPerim
    VLDR.f32    S3, [R0]
    LDR R0, =two
    VLDR.f32    S9, [R0]
    VDIV.f32    S4, S3, S9  @ s = (a+b+c)/2
    VSUB.f32    S5, S4, S0  @ s - a
    VMUL.f32    S8, S4, S5
    VSUB.f32    S6, S4, S1  @ s - b
    VMUL.f32    S8, S8, S6
    VSUB.f32    S7, S4, S2  @ s - c
    VMUL.f32    S8, S8, S7
    VSQRT.f32   S8, S8      @ area = sqrt(s*(s-a)*(s-b)*(s-c))
    LDR R0, =valArea
    VSTR        S8, [R0]
    LDR R0, =retarea
    LDR LR, [R0]
    BX LR
.endfunc

.func printrespuesta
printrespuesta:
    LDR R0, =retfin
    STR LR, [R0]
    LDR R0, =output @ print(perimetro)
    LDR R1, =valPerim
    VLDR.f32        S0, [R1]
    VCVT.f64.f32    D0, S0
    VMOV            R2, R3, D0
    BL  printf
    LDR R0, =output @ print(area)
    LDR R1, =valArea
    VLDR.f32        S0, [R1]
    VCVT.f64.f32    D0, S0
    VMOV            R2, R3, D0
    BL  printf
    LDR R0, =retfin
    LDR LR, [R0]
    BX LR
.endfunc

.func clasificacion_lados
clasificacion_lados:
    LDR R0, =retclasif
    STR LR, [R0]
    LDR R0, =segmenta
    VLDR.f32    S0, [R0]
    LDR R0, =segmentb
    VLDR.f32    S1, [R0]
    LDR R0, =segmentc
    VLDR.f32    S2, [R0]
    LDR R0, =precision
    VLDR.f32    S4, [R0]
cond0l:
    VSUB.f32    S3, S0, S1  @ comparacion de A con B caso 0
    VABS.f32    S3, S3
    VCMP.f32    S3, S4
    VMRS        APSR_nzcv, FPSCR
    BLT cond1l               @ segmentoA == segmentoB
    B   cond2l              @ segmentoA != segmentoB
cond1l:
    VSUB.f32    S3, S0, S2  @ comparacion de A con C caso 1
    VABS.f32    S3, S3
    VCMP.f32    S3, S4
    VMRS        APSR_nzcv, FPSCR
    BLT esEquilatero        @ segmentoA == segmentoC
    B   esIsosceles         @ segmentoA != segmentoC
cond2l:
    VSUB.f32    S3, S0, S2  @ comparacion de A con C caso 2
    VABS.f32    S3, S3
    VCMP.f32    S3, S4
    VMRS        APSR_nzcv, FPSCR
    BLT esIsosceles         @ segmentoA == segmentoC
    B   cond3l               @ segmentoA != segmentoC
cond3l:
    VSUB.f32    S3, S1, S2  @ comparacion de B con C caso 3
    VABS.f32    S3, S3
    VCMP.f32    S3, S4
    VMRS        APSR_nzcv, FPSCR
    BLT esIsosceles         @ segmentoB == segmentoC
    B   esEscaleno          @ segmentoB != segmentoC
esEquilatero:
    LDR R0, =equilatero
    BL printf
    B endclasificacion_lados
esIsosceles:
    LDR R0, =isoceles
    BL printf
    B endclasificacion_lados
esEscaleno:
    LDR R0, =escaleno
    BL printf
    B endclasificacion_lados
endclasificacion_lados:
    LDR R0, =retclasif
    LDR LR, [R0]
    BX LR
.endfunc


// Functions from pro05.s
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

.func clasificacion_angulos
clasificacion_angulos:
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
cond0a:
    VCMP.f32   S0, S3
    VMRS       APSR_nzcv, FPSCR
    BLT esObtusangulo
    B   cond1a
cond1a:
    VCMP.f32   S1, S3
    VMRS       APSR_nzcv, FPSCR
    BLT esObtusangulo
    B   cond2a
cond2a:
    VCMP.f32   S2, S3
    VMRS       APSR_nzcv, FPSCR
    BLT esObtusangulo
    B   esAcutangulo
esRectangulo:
    LDR R0, =rectangulo
    BL printf
    B endclasificacion_angulos
esAcutangulo:
    LDR R0, =acutangulo
    BL printf
    B endclasificacion_angulos
esObtusangulo:
    LDR R0, =obtusangulo
    BL printf
    B endclasificacion_angulos
endclasificacion_angulos:
    LDR R0, =retclasif
    LDR LR, [R0]
    BX LR
.endfunc

.end

