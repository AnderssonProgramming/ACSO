#include <stdio.h>

int main() {
    int numVectors;
    //printf("Enter the vectors number you wanna choose: ");
    scanf("%d",&numVectors);
     
    int numVector;
    for (numVector = 0; numVector < numVectors;numVector++){

     int n;
     //printf("\nEnter the vector size:\n ");
     scanf("%d", &n);

     float vec[n];
     //printf("Write every element of the vector:\n ");

     int i;
     for (i = 0; i < n; i++) {
         scanf("%f", &vec[i]);
     }

     float min = vec[0];
   
     for (i = 1; i < n; i++) {
         if (vec[i] < min) {
             min = vec[i];
         }
     }

     //printf("El mínimo del vector es:%f\n", min)
     printf("%f\n",min);
    }
     return 0;
    
}
