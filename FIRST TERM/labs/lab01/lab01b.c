#include <stdio.h>

int main(){
 float n1,n2;
 int n; 
 //printf("Enter the number of times you'll compare two numbers: ");
 scanf("%d",&n);

 int i;
 for (i=0;i<n;i++){
  //printf("\nTime %d \n",i+1);

  //printf("Enter the first number: ");
  scanf("%f",&n1);

  //printf("Enter the second number: ");
  scanf("%f",&n2);

  if (n1 > n2){
   //printf("The max number is %f\n",n1);
   printf("%f\n",n1);
  }
  else{
   //printf("The max number is %f\n",n2);
   printf("%f\n",n2);
  }

 }

 return 0;
}
