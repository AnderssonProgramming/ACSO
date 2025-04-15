#include <stdio.h>

#define MAX_VECTOR_SIZE 2000

// Function to read vector elements
void leerVector(int vector[], int *n) {
    scanf("%d", n);
    int i;
    for (i = 0; i < *n; i++) {
        scanf("%d", &vector[i]);
    }
}

// Function to calculate sum of vector elements
int sumaVector(int vector[], int n) {
    int suma = 0;
    int i;
    for (i = 0; i < n; i++) {
        suma += vector[i];
    }
    return suma;
}

int main() {
    int numVectors, n,i;
    int vector[MAX_VECTOR_SIZE];

    // Read number of vectors to process
    scanf("%d", &numVectors);

    // Process each vector
    for (i = 0; i < numVectors; i++) {
        // Read vector and calculate sum
        leerVector(vector, &n);
        int suma = sumaVector(vector, n);
        
        // Print sum
        printf("%d\n", suma);
    }

    return 0;
}
