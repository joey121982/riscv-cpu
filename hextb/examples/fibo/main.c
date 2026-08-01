int fibo(int n) {
    if (n < 2) return 1;
    else return fibo(n - 1) + fibo(n - 2); 
}

void main() {
    volatile int result = fibo(10);

    while (1) {}
}