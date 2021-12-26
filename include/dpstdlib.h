#ifndef _DPSTDLIB_H
#define _DPSTDLIB_H

#ifdef __cplusplus
/* Dummy function to avoid linker complaints */
extern "C" void __aeabi_unwind_cpp_pr0(void) {};
#endif

#include "common.h"
#include "job.h"

typedef struct {
    u32 pid;
    u16 isEncrypted0 :1;
    u16 isEncrypted1 :1;
    u16 isBadEgg     :1;
    u16              :13;
    u16 checksum;
    u8 abcd[0x80];
} BoxPokemon;

#define p_base       ((u32*) 0x02108818)

#define fp_malloc    0x02017099
#define fp_free      0x02016fdd
#define fp_decrypt   0x0206ee7d
#define fp_encrypt   0x0206eea5

static inline void* malloc(u32 size) {
    return (( void* (*)(u32, u32))fp_malloc) (2, size);
}

static inline void free(void* ptr) {
    ((void (*)(void*))fp_free) (ptr);
}

static inline void memcpy(void* target, const void* source, u32 size) {
    register const void* _source __asm__("r0") = source;
    register void* _target __asm__("r1") = target;
    register u32 _hwordCount __asm__("r2") = size/2;
    __asm__ volatile(
        "swi #0xb"
        :
        :"r"(_source), "r"(_target), "r"(_hwordCount)
        :
    );
}

static inline void decrypt(BoxPokemon* poke) {
    ((void (*)(BoxPokemon*))fp_decrypt) (poke);
}

static inline void encrypt(BoxPokemon* poke) {
    ((void (*)(BoxPokemon*, u32))fp_encrypt) (poke, 1);
}

#endif