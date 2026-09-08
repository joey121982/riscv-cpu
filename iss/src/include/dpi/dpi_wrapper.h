// TODO: add doxygen comments

#pragma once

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

void*       iss_create();
void        iss_destroy(void* iss_ptr);
void        iss_reset(void* iss_ptr);
int32_t     iss_load_program(void* iss_ptr, const char* filepath);

int32_t     iss_step(void* iss_ptr);
uint32_t    iss_get_pc(void* iss_ptr);
uint32_t    iss_get_reg(void* iss_ptr, int reg_index);
uint32_t    iss_read_mem(void* iss_ptr, uint32_t addr);

uint32_t    iss_get_last_inst(void* iss_ptr);
const char* iss_get_disassembly(void* iss_ptr);

#ifdef __cplusplus
}
#endif