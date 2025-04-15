#include <stdio.h>
#include <math.h>

int main() {
    int n;
    double a, b, c, discriminante, raiz1, raiz2;

    scanf("%d", &n);
    int i;
    for (i = 0; i < n; i++) {
        scanf("%lf\n",&a);
        scanf("%lf\n",&b);
        scanf("%lf\n",&c);

        discriminante = b * b - 4 * a * c;

        if (discriminante < 0) {
            printf("no roots\n");
        } else if (discriminante == 0) {
            raiz1 = -b / (2 * a);
            printf("%.2f\n", raiz1);
        } else {
            raiz1 = (-b + sqrt(discriminante)) / (2 * a);
            raiz2 = (-b - sqrt(discriminante)) / (2 * a);
            printf("%.2lf\n%.2lf\n", raiz1, raiz2);
        }
    }

    return 0;
}
