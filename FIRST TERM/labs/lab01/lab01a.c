#include <stdio.h>

int main(){
 int n,n1,n2,sum;

 //printf("Enter the number of sums you wanna do: ");
 scanf("%d",&n);

 int i;
 for (i=0;i<n;i++){
  //printf("\nSum %d\n",i+1);
  //printf("Enter the first number: ");
  scanf("%d",&n1);
  
  //printf("Enter the second number: ");
  scanf("%d",&n2);

  sum = n1 + n2;
  
  //printf("The sum of %d and %d is: %d\n ",n1,n2,sum);
  printf("%d\n",sum);
 }
 return 0;
}
