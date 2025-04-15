#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LENGTH 1000

// Función para multiplicar dos números grandes representados como cadenas
void multiply_large_numbers(char *num1, char *num2) {
    int len1 = strlen(num1);
    int len2 = strlen(num2);
    int result[MAX_LENGTH * 2] = {0}; // Asegurar suficiente espacio
    int i, j;
    
    for (i = len1 - 1; i >= 0; i--) {
        for (j = len2 - 1; j >= 0; j--) {
            int mul = (num1[i] - '0') * (num2[j] - '0');
            int sum = mul + result[i + j + 1];
            
            result[i + j + 1] = sum % 10;
            result[i + j] += sum / 10;
        }
    }
    
    // Imprimir el resultado eliminando ceros iniciales
    i = 0;
    while (i < (len1 + len2) && result[i] == 0) {
        i++;
    }
    
    if (i == len1 + len2) {
        printf("0\n");
    } else {
        for (; i < (len1 + len2); i++) {
            printf("%d", result[i]);
        }
        printf("\n");
    }
}

int main() {
    int n, i;
    scanf("%d", &n);
    
    for (i = 0; i < n; i++) {
        char num1[MAX_LENGTH + 1], num2[MAX_LENGTH + 1];
        scanf("%s %s", num1, num2);
        
        multiply_large_numbers(num1, num2);
    }
    
    return 0;
}
