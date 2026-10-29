#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define LIMIT 100000

bool is_prime[LIMIT + 1];

void eratosthenes() {
    for (int n = 0; n <= LIMIT; n++)
        is_prime[n] = n >= 2;
    for (int prime = 2; prime <= LIMIT; prime++)
        if (is_prime[prime])
            for (int n = 2 * prime; n <= LIMIT; n += prime)
                is_prime[n] = false;
}

void goldbach(int n) {
    for (int p = 2; p <= n; p++)
        if (is_prime[p] && is_prime[n - p]) {
            printf("(%d,%d)\n", p, n - p);
            return;
        }
}

void mystery_function(int n) {
    printf("[");
    while (abs(n) != 1) {
        int p = 2;
        while (!is_prime[p] || n % p != 0) p++;
        printf("%d,", p);
        n /= p;
    }
    printf("\b]\n");
}

int main() {
    int n;
    scanf("%d", &n);
    eratosthenes();
    goldbach(n);
    mystery_function(n);
    return 0;
}
