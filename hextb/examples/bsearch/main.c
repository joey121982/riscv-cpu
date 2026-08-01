int binary_search(int* vec, int left, int right, int target) {
    if (left > right) return 0;
    
    int mid = (left + right) / 2;
    if (target == vec[mid]) return 1;
    if (target > vec[mid]) return binary_search(vec, mid + 1, right, target);
    if (target < vec[mid]) return binary_search(vec, left, mid - 1, target);
}

void main() {
    int vec[16];
    for(int i = 0; i < 16; i++) vec[i] = i;
    
    volatile int result = binary_search(vec, 0, 15, 9);
    
    while (1) {}
    return;
}