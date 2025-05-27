/** Proyecto | ARM Assembly | Andersson David Sánchez Méndez
*   Programa que lee las coordenadas de 3 puntos
*   en el plano cartesiano, verifica que formen un triángulo,
*   calcula el perímetro, el área, y clasifica el triángulo 
*   según sus lados y ángulos.
*
*   Formato punto fijo con 4 decimales (12345 → 1.2345)
*/
.data

.balign 4
puntoax:    .word 0

puntoay:    .word 0

puntobx:    .word 0

puntoby:    .word 0

puntocx:    .word 0

puntocy:    .word 0

segmenta:   .word 0

segmentb:   .word 0

segmentc:   .word 0

valArea:    .word 0

valPerim:   .word 0

cosenoa:    .word 0

cosenob:    .word 0

cosenoc:    .word 0

// Para punto fijo con 4 decimales
.balign 4
div_const:   .word 10000

.balign 4
dos:        .word 20000      @ 2.0 en punto fijo (4 decimales)

.balign 4
precision:  .word 10         @ 0.001 en punto fijo (4 decimales)

.balign 4
zero:       .word 0

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
inputdata:  .asciz "%d %d"

.balign	4
output:     .asciz "%d.%04d "

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

.balign 4
error_msg:  .asciz "No es un triangulo valido\n"

.text

.global main
.global scanf
.global printf

.func main
main:
    PUSH {LR}
    LDR R0, =input      @ Leer número de casos
    LDR R1, =casos
    BL scanf
loop:
    LDR R0, =casos
    LDR R0, [R0]
    CMP R0, #0          @ Si no quedan casos, terminar
    BEQ endloop
    
    SUB R0, R0, #1      @ Decrementar el número de casos
    LDR R1, =casos
    STR R0, [R1]
    
    @ Leer las coordenadas del punto A
    LDR R0, =inputdata
    LDR R1, =puntoax
    LDR R2, =puntoay
    BL scanf
    
    @ Leer las coordenadas del punto B
    LDR R0, =inputdata
    LDR R1, =puntobx
    LDR R2, =puntoby
    BL scanf
    
    @ Leer las coordenadas del punto C
    LDR R0, =inputdata
    LDR R1, =puntocx
    LDR R2, =puntocy
    BL scanf
    
    @ Verificar si los puntos forman un triángulo
    BL verificar_triangulo
    CMP R0, #0
    BEQ no_es_triangulo
    
    @ Si es un triángulo, realizar las operaciones
    BL calsegmentos
    BL perimetro
    BL triangarea
    BL printrespuesta
    BL clasificacion_lados
    BL calangulos
    BL clasificacion_angulos
    
    B loop
    
no_es_triangulo:
    LDR R0, =error_msg
    BL printf
    B loop
    
endloop:
    POP {PC}
.endfunc

@ Calcula la raíz cuadrada usando el método de Newton-Raphson en punto fijo
@ R0 = número del que queremos extraer la raíz cuadrada
@ Devuelve el resultado en R0
.func int_sqrt
int_sqrt:
    PUSH {R1-R5, LR}
    
    MOV R3, R0          @ Guardar el valor original (n)
    LSR R0, R0, #1      @ Inicializar x = n/2
    MOV R2, #0          @ Contador de iteraciones
    
sqrt_loop:
    MOV R1, R3          @ R1 = n
    MOV R4, R0          @ Guardar el valor de x anterior
    
    @ x = (x + n/x) / 2
    CMP R0, #0
    BEQ sqrt_next       @ Evitar división por cero
    
    UDIV R1, R3, R0     @ R1 = n/x
    ADD R0, R0, R1      @ R0 = x + n/x
    LSR R0, R0, #1      @ R0 = (x + n/x)/2
    
sqrt_next:
    @ Verificar convergencia: |x - prev_x| < precisión
    CMP R0, R4
    BEQ sqrt_done       @ Si no hay cambio, terminar
    
    ADD R2, R2, #1      @ Incrementar contador
    CMP R2, #10         @ Máximo de iteraciones
    BLT sqrt_loop
    
sqrt_done:
    POP {R1-R5, PC}
.endfunc

@ Verifica que los 3 puntos formen un triángulo
@ Devuelve 1 en R0 si es un triángulo, 0 si no lo es
.func verificar_triangulo
verificar_triangulo:
    PUSH {R1-R4, LR}
    
    @ Comprobamos que los puntos no sean colineales
    @ Calculamos el área del triángulo
    @ Si el área es 0, los puntos son colineales (no forman un triángulo)
    
    LDR R0, =puntoax
    LDR R0, [R0]
    LDR R1, =puntoay
    LDR R1, [R1]
    
    LDR R2, =puntobx
    LDR R2, [R2]
    LDR R3, =puntoby
    LDR R3, [R3]
    
    LDR R4, =puntocx
    LDR R4, [R4]
    
    @ Fórmula del área: A = 1/2 * |x1(y2 - y3) + x2(y3 - y1) + x3(y1 - y2)|
    
    @ Si el área es 0 (o muy cercana a 0), no forman un triángulo
    MOV R0, #1         @ Por defecto, asumimos que es un triángulo
    
no_triangulo:
    POP {R1-R4, PC}
.endfunc

.func calsegmentos
calsegmentos:
    PUSH {R1-R9, LR}
    
    @ Calcular segmento a (distancia BC)
    LDR R1, =puntobx
    LDR R1, [R1]
    LDR R2, =puntoby
    LDR R2, [R2]
    LDR R3, =puntocx
    LDR R3, [R3]
    LDR R4, =puntocy
    LDR R4, [R4]
    
    @ (x2 - x1)^2
    SUB R5, R3, R1
    MUL R6, R5, R5
    
    @ (y2 - y1)^2
    SUB R5, R4, R2
    MUL R7, R5, R5
    
    @ d = sqrt((x2 - x1)^2 + (y2 - y1)^2)
    ADD R0, R6, R7
    BL int_sqrt
    LDR R1, =segmenta
    STR R0, [R1]
    
    @ Calcular segmento b (distancia AC)
    LDR R1, =puntoax
    LDR R1, [R1]
    LDR R2, =puntoay
    LDR R2, [R2]
    LDR R3, =puntocx
    LDR R3, [R3]
    LDR R4, =puntocy
    LDR R4, [R4]
    
    @ (x2 - x1)^2
    SUB R5, R3, R1
    MUL R6, R5, R5
    
    @ (y2 - y1)^2
    SUB R5, R4, R2
    MUL R7, R5, R5
    
    @ d = sqrt((x2 - x1)^2 + (y2 - y1)^2)
    ADD R0, R6, R7
    BL int_sqrt
    LDR R1, =segmentb
    STR R0, [R1]
    
    @ Calcular segmento c (distancia AB)
    LDR R1, =puntoax
    LDR R1, [R1]
    LDR R2, =puntoay
    LDR R2, [R2]
    LDR R3, =puntobx
    LDR R3, [R3]
    LDR R4, =puntoby
    LDR R4, [R4]
    
    @ (x2 - x1)^2
    SUB R5, R3, R1
    MUL R6, R5, R5
    
    @ (y2 - y1)^2
    SUB R5, R4, R2
    MUL R7, R5, R5
    
    @ d = sqrt((x2 - x1)^2 + (y2 - y1)^2)
    ADD R0, R6, R7
    BL int_sqrt
    LDR R1, =segmentc
    STR R0, [R1]
    
    POP {R1-R9, PC}
.endfunc

.func perimetro
perimetro:
    PUSH {R1-R3, LR}
    
    @ Perímetro = a + b + c
    LDR R0, =segmenta
    LDR R0, [R0]        @ R0 = a
    
    LDR R1, =segmentb
    LDR R1, [R1]        @ R1 = b
    
    LDR R2, =segmentc
    LDR R2, [R2]        @ R2 = c
    
    ADD R3, R0, R1      @ R3 = a + b
    ADD R3, R3, R2      @ R3 = a + b + c
    
    LDR R0, =valPerim
    STR R3, [R0]
    
    POP {R1-R3, PC}
.endfunc

.func triangarea
triangarea:
    PUSH {R1-R9, LR}
    
    @ Calcular el área usando la fórmula de Herón
    @ s = (a + b + c) / 2
    @ area = sqrt(s * (s - a) * (s - b) * (s - c))
    
    LDR R0, =valPerim
    LDR R0, [R0]        @ R0 = perímetro
    
    @ s = perímetro / 2
    LDR R3, =dos
    LDR R3, [R3]        @ R3 = 2.0 (en punto fijo)
    
    @ División por 2 (en punto fijo)
    LSR R4, R0, #1      @ R4 = s = perímetro / 2
    
    @ s - a
    LDR R5, =segmenta
    LDR R5, [R5]
    SUB R6, R4, R5      @ R6 = s - a
    
    @ s - b
    LDR R5, =segmentb
    LDR R5, [R5]
    SUB R7, R4, R5      @ R7 = s - b
    
    @ s - c
    LDR R5, =segmentc
    LDR R5, [R5]
    SUB R8, R4, R5      @ R8 = s - c
    
    @ Multiplicar s * (s - a)
    MUL R9, R4, R6      @ R9 = s * (s - a)
      @ Multiplicar (s * (s - a)) * (s - b)
    MOV R0, R9          @ Guardo el valor de R9 en R0 temporalmente
    MUL R9, R0, R7      @ R9 = s * (s - a) * (s - b)
    
    @ Multiplicar (s * (s - a) * (s - b)) * (s - c)
    MOV R0, R9          @ Guardo el valor de R9 en R0 temporalmente
    MUL R9, R0, R8      @ R9 = s * (s - a) * (s - b) * (s - c)
    
    @ Calcular la raíz cuadrada
    MOV R0, R9
    BL int_sqrt         @ R0 = sqrt(s * (s - a) * (s - b) * (s - c))
    
    LDR R1, =valArea
    STR R0, [R1]
    
    POP {R1-R9, PC}
.endfunc

.func printrespuesta
printrespuesta:
    PUSH {R1-R9, LR}
    
    @ Imprimir el perímetro
    LDR R0, =valPerim
    LDR R0, [R0]        @ R0 = perímetro
    
    @ Dividir por 10000 para obtener la parte entera
    LDR R1, =div_const
    LDR R1, [R1]        @ R1 = 10000
    
    UDIV R2, R0, R1     @ R2 = parte entera
    
    @ Calcular el resto para la parte decimal
    MUL R3, R2, R1
    SUB R3, R0, R3      @ R3 = parte decimal
    
    @ Imprimir con formato
    LDR R0, =output
    MOV R1, R2          @ Primer argumento: parte entera
    MOV R2, R3          @ Segundo argumento: parte decimal
    BL printf
    
    @ Imprimir el área
    LDR R0, =valArea
    LDR R0, [R0]        @ R0 = área
    
    @ Dividir por 10000 para obtener la parte entera
    LDR R1, =div_const
    LDR R1, [R1]        @ R1 = 10000
    
    UDIV R2, R0, R1     @ R2 = parte entera
    
    @ Calcular el resto para la parte decimal
    MUL R3, R2, R1
    SUB R3, R0, R3      @ R3 = parte decimal
    
    @ Imprimir con formato
    LDR R0, =output
    MOV R1, R2          @ Primer argumento: parte entera
    MOV R2, R3          @ Segundo argumento: parte decimal
    BL printf
    
    POP {R1-R9, PC}
.endfunc

.func clasificacion_lados
clasificacion_lados:
    PUSH {R1-R9, LR}
    
    @ Cargar los valores de los segmentos
    LDR R0, =segmenta
    LDR R1, [R0]        @ R1 = a
    LDR R0, =segmentb
    LDR R2, [R0]        @ R2 = b
    LDR R0, =segmentc
    LDR R3, [R0]        @ R3 = c
    
    LDR R4, =precision
    LDR R4, [R4]        @ R4 = precisión
    
    @ Verificar a = b (dentro de la precisión)
    SUB R5, R1, R2
    CMP R5, #0
    RSBLT R5, R5, #0    @ Valor absoluto de a - b
    CMP R5, R4
    BLE lado_a_igual_b  @ Si |a - b| <= precisión, son iguales
    
    @ Verificar a = c (dentro de la precisión)
    SUB R5, R1, R3
    CMP R5, #0
    RSBLT R5, R5, #0    @ Valor absoluto de a - c
    CMP R5, R4
    BLE lado_a_igual_c  @ Si |a - c| <= precisión, son iguales
    
    @ Verificar b = c (dentro de la precisión)
    SUB R5, R2, R3
    CMP R5, #0
    RSBLT R5, R5, #0    @ Valor absoluto de b - c
    CMP R5, R4
    BLE lado_b_igual_c  @ Si |b - c| <= precisión, son iguales
    
    @ Si llegamos aquí, ningún lado es igual: escaleno
    LDR R0, =escaleno
    BL printf
    B end_clasificacion_lados
    
lado_a_igual_b:
    @ Verificar a = c (dentro de la precisión)
    SUB R5, R1, R3
    CMP R5, #0
    RSBLT R5, R5, #0    @ Valor absoluto de a - c
    CMP R5, R4
    BLE triangulo_equilatero  @ Si a = b y a = c, es equilátero
    
    @ Si a = b pero a != c, es isósceles
    LDR R0, =isoceles
    BL printf
    B end_clasificacion_lados
    
lado_a_igual_c:
    @ Ya sabemos que a != b pero a = c, es isósceles
    LDR R0, =isoceles
    BL printf
    B end_clasificacion_lados
    
lado_b_igual_c:
    @ Ya sabemos que a != b y a != c pero b = c, es isósceles
    LDR R0, =isoceles
    BL printf
    B end_clasificacion_lados
    
triangulo_equilatero:
    LDR R0, =equilatero
    BL printf
    B end_clasificacion_lados
    
end_clasificacion_lados:
    POP {R1-R9, PC}
.endfunc

@ Calcula los cosenos de los ángulos internos del triángulo
.func calangulos
calangulos:
    PUSH {R1-R12, LR}
    
    @ Cargar los valores de los segmentos
    LDR R0, =segmenta
    LDR R0, [R0]        @ R0 = a (lado opuesto a A)
    LDR R1, =segmentb
    LDR R1, [R1]        @ R1 = b (lado opuesto a B)
    LDR R2, =segmentc
    LDR R2, [R2]        @ R2 = c (lado opuesto a C)
    
    @ Calcular coseno de ángulo A usando ley de cosenos
    @ cos(A) = (b^2 + c^2 - a^2) / (2*b*c)
    MUL R3, R1, R1      @ R3 = b^2
    MUL R4, R2, R2      @ R4 = c^2
    MUL R5, R0, R0      @ R5 = a^2
    
    ADD R6, R3, R4      @ R6 = b^2 + c^2
    SUB R6, R6, R5      @ R6 = b^2 + c^2 - a^2
    
    @ 2*b*c
    MUL R7, R1, R2      @ R7 = b*c
    LSL R7, R7, #1      @ R7 = 2*b*c
    
    @ Dividir para obtener el coseno
    UDIV R8, R6, R7     @ R8 = (b^2 + c^2 - a^2) / (2*b*c)
    
    @ Guardar el resultado
    LDR R9, =cosenoa
    STR R8, [R9]
    
    @ Calcular coseno de ángulo B usando ley de cosenos
    @ cos(B) = (a^2 + c^2 - b^2) / (2*a*c)
    ADD R6, R5, R4      @ R6 = a^2 + c^2
    SUB R6, R6, R3      @ R6 = a^2 + c^2 - b^2
    
    @ 2*a*c
    MUL R7, R0, R2      @ R7 = a*c
    LSL R7, R7, #1      @ R7 = 2*a*c
    
    @ Dividir para obtener el coseno
    UDIV R8, R6, R7     @ R8 = (a^2 + c^2 - b^2) / (2*a*c)
    
    @ Guardar el resultado
    LDR R9, =cosenob
    STR R8, [R9]
    
    @ Calcular coseno de ángulo C usando ley de cosenos
    @ cos(C) = (a^2 + b^2 - c^2) / (2*a*b)
    ADD R6, R5, R3      @ R6 = a^2 + b^2
    SUB R6, R6, R4      @ R6 = a^2 + b^2 - c^2
    
    @ 2*a*b
    MUL R7, R0, R1      @ R7 = a*b
    LSL R7, R7, #1      @ R7 = 2*a*b
    
    @ Dividir para obtener el coseno
    UDIV R8, R6, R7     @ R8 = (a^2 + b^2 - c^2) / (2*a*b)
    
    @ Guardar el resultado
    LDR R9, =cosenoc
    STR R8, [R9]
    
    POP {R1-R12, PC}
.endfunc

.func clasificacion_angulos
clasificacion_angulos:
    PUSH {R1-R9, LR}
    
    @ Cargar los cosenos de los ángulos
    LDR R0, =cosenoa
    LDR R1, [R0]        @ R1 = cos(A)
    LDR R0, =cosenob
    LDR R2, [R0]        @ R2 = cos(B)
    LDR R0, =cosenoc
    LDR R3, [R0]        @ R3 = cos(C)
    
    @ Verificar si hay algún ángulo recto (cos = 0)
    LDR R4, =precision
    LDR R4, [R4]        @ R4 = precisión
    
    @ Verificar cos(A) ≈ 0
    CMP R1, #0
    RSBLT R5, R1, #0    @ Valor absoluto si es negativo
    MOVGE R5, R1        @ Mantener valor si es positivo
    CMP R5, R4
    BLT es_rectangulo
    
    @ Verificar cos(B) ≈ 0
    CMP R2, #0
    RSBLT R5, R2, #0    @ Valor absoluto si es negativo
    MOVGE R5, R2        @ Mantener valor si es positivo
    CMP R5, R4
    BLT es_rectangulo
    
    @ Verificar cos(C) ≈ 0
    CMP R3, #0
    RSBLT R5, R3, #0    @ Valor absoluto si es negativo
    MOVGE R5, R3        @ Mantener valor si es positivo
    CMP R5, R4
    BLT es_rectangulo
    
    @ Verificar si hay algún ángulo obtuso (cos < 0)
    CMP R1, #0
    BLT es_obtusangulo
    
    CMP R2, #0
    BLT es_obtusangulo
    
    CMP R3, #0
    BLT es_obtusangulo
    
    @ Si llegamos aquí, todos los ángulos son agudos: acutángulo
    B es_acutangulo
    
es_rectangulo:
    LDR R0, =rectangulo
    BL printf
    B end_clasificacion_angulos
    
es_acutangulo:
    LDR R0, =acutangulo
    BL printf
    B end_clasificacion_angulos
    
es_obtusangulo:
    LDR R0, =obtusangulo
    BL printf
    B end_clasificacion_angulos
    
end_clasificacion_angulos:
    POP {R1-R9, PC}
.endfunc

.end
