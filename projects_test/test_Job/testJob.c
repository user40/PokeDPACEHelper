/**
 * @file testJob.c
 * @brief Jobまわりのテスト
 */

#include "dpstdlib.h"

#define offset_money 0x28C

void jobfunc(Job* job, void* work);

void main(u32 pc, u32 dummy1, u32 dummy2, u8 mark) {
    addJob((jobFunc)&jobfunc, 0, 0);
}

/**
 * @brief 所持金を1円ふやす
 * 
 * @param job 
 * @param work 
 */
void jobfunc(Job* job, void* work) {
    u32* p_money = (u32*)(*p_base + 0x28C);
    (*p_money)++;
}
