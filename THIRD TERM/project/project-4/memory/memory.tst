// Archivo de testeo para memory del Proyecto 4
// A tener en cuenta:
// %B binary
// %D decimal
// %H hexa
// Salida dada en tabla binaria con 12 bits 
// 3 espacios vacios a lado izquierdo y derecho
// %B3.12.3
// ejemplo |   000000000000   |

load memory.hdl,
output-file memory.out,
output-list time%S1.6.1 out2%B3.12.3 out1%B3.12.3 out0%B3.12.3;


set a %B00000,
set w 0,
set in2 %B1111111111111111,
set in1 %B1111111111111111,
set in0 %B1111111111111111,
tick,
output;
tock,
output;

set w 1,
tick,
output;
tock,
output;

set a %B00000,
eval,
output;


