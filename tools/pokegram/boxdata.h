#ifndef BOXDATA_H
#define BOXDATA_H

#include "common.h"

struct boxdata{
    u32 pid;
    u16 isDecrypted1 :1;
    u16 isDecrypted2 :1;
    u16 isDametamago :1;
    u16 :13;
    u16 checksum;
    ABCD abcd;

    public:
        void encrypt();
        bool setValidChecksum();

    private:
        u16 calcChecksum(u16 key);
        u32 nextRand(u32 rand);
        u16 mask(u16 data, u32 key);
};

inline u32 boxdata::nextRand(u32 rand) {
    return rand * 1103515245L + 24691;
}

inline u16 boxdata::mask(u16 data, u32 key) {
    return data ^ (key >> 16);
}

#endif // BOXDATA_H