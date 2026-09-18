#include <stdint.h>

#define PORT0_IDR (*(volatile uint32_t*)0x8000)
#define PORT0_ODR (*(volatile uint32_t*)0x8004)
#define PORT0_DDR (*(volatile uint32_t*)0x8008)

int main() {
    PORT0_IDR = 0x5555; // fails, because IDR is read-only
    PORT0_ODR = 0xFFFF;
    PORT0_DDR = 0xFF00;

    while (1) {
        ;
    }
}