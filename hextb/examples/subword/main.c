void main() {
    // 1. Test Store Byte (SB)
    volatile signed char bytes[4];
    bytes[0] = 0x7F; // Positive 8-bit (127)
    bytes[1] = 0x80; // Negative 8-bit (-128)

    // 2. Test Load Byte (LB) - Checks Sign Extension
    volatile int read_pos_byte = bytes[0]; // Should read 0x0000007F
    volatile int read_neg_byte = bytes[1]; // Should read 0xFFFFFF80

    // 3. Test Load Byte Unsigned (LBU) - Checks Zero Padding
    volatile unsigned char* u_bytes = (volatile unsigned char*)bytes;
    volatile int read_u_neg_byte = u_bytes[1]; // Should read 0x00000080

    // 4. Test Store Halfword (SH)
    volatile signed short halfs[2];
    halfs[0] = 0x7FFF; // Positive 16-bit
    halfs[1] = 0x8000; // Negative 16-bit

    // 5. Test Load Halfword (LH) - Checks Sign Extension
    volatile int read_pos_half = halfs[0]; // Should read 0x00007FFF
    volatile int read_neg_half = halfs[1]; // Should read 0xFFFF8000

    while (1) {}
}