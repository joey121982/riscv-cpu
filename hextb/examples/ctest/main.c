void _start(void) {
    volatile int x = 10;
    volatile int y = 20;
    
    volatile int sum = x + y;
    volatile int diff = x - y;

    while(1) {}
    return;
}