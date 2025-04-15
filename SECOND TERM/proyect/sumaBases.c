#include <stdio.h>
#include <string.h>

#define MAX_LENGTH 1000

// Función para sumar dos números grandes representados como cadenas
void sum_large_numbers(char *num1, char *num2) {
    int len1 = strlen(num1);
    int len2 = strlen(num2);
    int max_len = (len1 > len2 ? len1 : len2) + 1; // Espacio para posible acarreo extra
    int sum[max_len];  // Usamos un arreglo de enteros para almacenar cada dígito del resultado
    int i, j, k;
    
    // Inicializar el arreglo de suma con ceros
    for(i = 0; i < max_len; i++) {
        sum[i] = 0;
    }
    
    int carry = 0;
    i = len1 - 1;
    j = len2 - 1;
    k = max_len - 1;
    
    // Sumar dígito a dígito desde el final
    while(i >= 0 || j >= 0 || carry) {
        int digit1 = (i >= 0) ? num1[i] - '0' : 0;
        int digit2 = (j >= 0) ? num2[j] - '0' : 0;
        int s = digit1 + digit2 + carry;
        sum[k] = s % 10;
        carry = s / 10;
        i--;
        j--;
        k--;
    }
    
    // Imprimir el resultado eliminando ceros iniciales
    k = 0;
    // Evitar imprimir todos los dígitos si el resultado es 0
    while(k < max_len - 1 && sum[k] == 0) {
        k++;
    }
    for(; k < max_len; k++) {
        printf("%d", sum[k]);
    }
    printf("\n");
}

int main() {
    int n, i;
    scanf("%d", &n);
    
    for(i = 0; i < n; i++) {
        char num1[MAX_LENGTH + 1], num2[MAX_LENGTH + 1];
        scanf("%s %s", num1, num2);
        sum_large_numbers(num1, num2);
    }
    
    return 0;
}

