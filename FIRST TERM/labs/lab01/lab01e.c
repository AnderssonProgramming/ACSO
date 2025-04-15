#include <stdio.h>

int main() {
    float n1, n2;
    int n;
    char operation;
    
    //printf("Enter the number of operations: ");
    scanf("%d", &n);
    
    // Consume the newline character left in the input buffer
    getchar();
    
    int i;
    for (i = 0; i < n; i++) {
        //printf("\nOperation %d \n", i+1);
        //printf("Enter the operation (+, -, *, /): ");
        scanf("%c\n", &operation);
        
        //printf("Enter the first number: ");
        scanf("%f\n", &n1);
        
        //printf("Enter the second number: ");
        scanf("%f\n", &n2);
        
        switch(operation) {
            case '+':
                //printf("The result is %f\n", n1 + n2);
                printf("%f\n",n1+n2);
                break;
            case '-':
                //printf("The result is %f\n", n1 - n2);
                printf("%f\n",n1-n2);
                break;
            case '*':
                //printf("The result is %f\n", n1 * n2);
                printf("%f\n",n1*n2);
                break;
            case '/':
                if (n2 != 0) {
                    //printf("The result is %f\n", n1 / n2);
                    printf("%f\n",n1/n2);
                } else {
                    printf("Error: Division by zero\n");
                }
                break;
            default:
                printf("Invalid operation\n");
        }
    }
    
    return 0;
}
