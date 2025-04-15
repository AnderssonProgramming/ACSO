#include <stdio.h>

int main() {
    int n, base, i, j, start; // Declarar TODAS las variables al inicio
    char s[1001];
    scanf("%d", &n);
    
    while (n--) {
        scanf("%d %1000s", &base, s);
        int result[4000] = {0};
        int result_len = 1; 
        int carry, d; // Declarar dentro del bloque pero al inicio
        
        for (i = 0; s[i]; ++i) {
            char c = s[i];
            if (c >= '0' && c <= '9') d = c - '0';
            else if (c >= 'A' && c <= 'Z') d = 10 + (c - 'A');
            else d = 10 + (c - 'a');
            
            // Multiplicar por base
            carry = 0;
            for (j = 0; j < result_len; ++j) {
                int temp = result[j] * base + carry;
                result[j] = temp % 10;
                carry = temp / 10;
            }
            
            while (carry > 0) {
                result[result_len++] = carry % 10;
                carry /= 10;
            }
            
            // Sumar dígito
            carry = d;
            for (j = 0; j < result_len && carry > 0; ++j) {
                int sum = result[j] + carry;
                result[j] = sum % 10;
                carry = sum / 10;
            }
            
            while (carry > 0) {
                result[result_len++] = carry % 10;
                carry /= 10;
            }
        }
        
        start = result_len - 1;
        while (start >= 0 && result[start] == 0) start--;
        
        if (start == -1) {
            printf("0\n");
        } else {
            for (i = start; i >= 0; i--) {
                printf("%d", result[i]);
            }
            printf("\n");
        }
    }
    return 0;
}