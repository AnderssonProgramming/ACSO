// Archivo de testeo para el add del Proyecto 4
// A tener en cuenta:
// %B binary
// %D decimal
// %H hexa
// Salida dada en tabla binaria con 12 bits 
// 3 espacios vacios a lado izquierdo y derecho
// %B3.12.3
// ejemplo |   000000000000   |

load add.hdl,
output-file add.out,
output-list c2%B3.12.3 c1%B3.12.3 c0%B3.12.3;

set a2 %B000111110100,
set a1 %B000000000000,
set a0 %B000000000000,
set b2 %B000111110100,
set b1 %B000000000000,
set b0 %B000111110100,
eval, output;

set a2 %B000000000000,
set a1 %B000111110100,
set a0 %B000000000000,
set b2 %B000000000000,
set b1 %B000111110100,
set b0 %B000000000001,
eval, output;

set a2 %B000000000000,
set a1 %B000000000000,
set a0 %B000111110100,
set b2 %B000000000000,
set b1 %B000000000000,
set b0 %B000111110100,
eval, output;
