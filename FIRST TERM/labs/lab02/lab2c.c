
#include <stdio.h>

void fraccionEgipcia(int numerador, int denominador) {
    while (numerador != 0) {
        int fraccionUnitaria = (denominador + numerador - 1) / numerador;  // División entera redondeando hacia arriba
        printf("%d\n", fraccionUnitaria);

        numerador = numerador * fraccionUnitaria - denominador;
        denominador *= fraccionUnitaria;
    }

    printf("0\n");
}

int main() {
    int casos, numerador, denominador;

    scanf("%d", &casos);
    int i;
    for (i = 0; i < casos; i++) {
        scanf("%d %d", &numerador, &denominador);

        fraccionEgipcia(numerador, denominador);
    }

    return 0;
}
