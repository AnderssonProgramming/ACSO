#include <stdio.h>
#include <math.h>

// Función para calcular el MCD usando el algoritmo de Euclides
int calcularMCD(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int main() {
    int casos, pasajerosBelgica, pasajerosInglaterra, pasajerosNoruega, pasajerosIrlanda, pasajerosFrancia;
    int totalPasajeros, capacidadAvion, avionesBelgica, avionesInglaterra, avionesNoruega, avionesIrlanda, avionesFrancia, totalAviones;

    // Leer el número de casos
    scanf("%d", &casos);
    int i;
    for (i = 0; i < casos; i++) {
        // Leer el número de pasajeros para cada país
        scanf("%d %d %d %d %d", &pasajerosBelgica, &pasajerosInglaterra, &pasajerosNoruega, &pasajerosIrlanda, &pasajerosFrancia);

        // Calcular el MCD de todos los pasajeros para obtener la capacidad uniforme
        capacidadAvion = calcularMCD(
            calcularMCD(
                calcularMCD(pasajerosBelgica, pasajerosInglaterra),
                calcularMCD(pasajerosNoruega, pasajerosIrlanda)
            ),
            pasajerosFrancia
        );

        // Calcular el número de aviones necesarios para cada país
        avionesBelgica = pasajerosBelgica / capacidadAvion;
        avionesInglaterra = pasajerosInglaterra / capacidadAvion;
        avionesNoruega = pasajerosNoruega / capacidadAvion;
        avionesIrlanda = pasajerosIrlanda / capacidadAvion;
        avionesFrancia = pasajerosFrancia / capacidadAvion;

        // Calcular el total de aviones
        totalAviones = avionesBelgica + avionesInglaterra + avionesNoruega + avionesIrlanda + avionesFrancia;

        // Imprimir la salida
        printf("%d\n", capacidadAvion);
        printf("%d\n%d\n%d\n%d\n%d\n", avionesBelgica, avionesInglaterra, avionesNoruega, avionesIrlanda, avionesFrancia);
        printf("%d\n", totalAviones);
    }

    return 0;
}
