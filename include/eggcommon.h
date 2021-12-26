#if !defined(_EGGCOMMON_H)
#define _EGGCOMMON_H

#include "dpstdlib.h"

// タマゴ１つに保存できるデータ
typedef u8 data68[0x68];
typedef struct {
    u8 eggNum;              // 展開したいタマゴの個数
    u8 dummy[2];
    u8 isAutoRun;           // 展開と同時に実行する(1), 展開のみする(0)
    u16 isEncrypted0 :1;
    u16 isEncrypted1 :1;
    u16 isBadEgg     :1;
    u16              :13;
    u16 checksum;
} Header;

typedef struct {
    Header header;
    data68 data;
    u8 dummy1[0x18];
} BoxPokemonAsData;

typedef struct {
    Header header;
    data68 data[1];
} EggsData;

#define headersize sizeof(Header)

#endif // _EGGCOMMON_H


