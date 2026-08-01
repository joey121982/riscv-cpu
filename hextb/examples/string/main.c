void main() {
    char test[7];
    test[0] = 'H';
    test[1] = 'e';
    test[2] = 'l';
    test[3] = 'l';
    test[4] = 'o';
    test[5] = '!';
    test[6] = '\0';
    
    volatile int result = (int)test[0];

    while (1) {}
    return;
}