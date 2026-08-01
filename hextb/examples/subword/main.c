void main() {
    volatile signed char bytes[4];
    bytes[0] = 0x7F;
    bytes[1] = 0x80;

    volatile int read_pos_byte = bytes[0];
    volatile int read_neg_byte = bytes[1];

    volatile unsigned char* u_bytes = (volatile unsigned char*)bytes;
    volatile int read_u_neg_byte = u_bytes[1];

    volatile signed short halfs[2];
    halfs[0] = 0x7FFF;
    halfs[1] = 0x8000;

    volatile int read_pos_half = halfs[0];
    volatile int read_neg_half = halfs[1];

    while (1) {}
}