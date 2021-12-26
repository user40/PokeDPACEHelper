/*
* 複数のタマゴに保存されたデータを連結し、指定のアドレスにコピーする。また指定があればそれを実行する。
*
* このプログラムが書き込まれたタマゴにマークをつけると、その右に続くタマゴを復号しデータを
* コピーする。コピーするアドレスはデフォルトでは0x0229008で、マークによってオフセットを指定できる。
* 具体的にはアドレス (0x0229008 + 0x100 * mark) に展開する。
* コピーするタマゴの数と、コピー後に実行するか否かは1つ目のタマゴのヘッダで指定する;
* eggNum はコピーするタマゴの数を指定する。
* isAutRun が1のときはコピー後にそれを実行する。
*/

#include "dpstdlib.h"
#include "eggcommon.h"

#define defalutTarget 0x02290000
#define offsetScale 0x100

static inline void call(void* funcAddr) {
    ((void (*)())(funcAddr)) ();
}

// markingACEを使ってジャンプしてきたならばr0にはこのプログラムの開始アドレスがセットされている
void loadEgg(BoxPokemon* selected, u32 dummy1, u32 dummy2, u8 mark) {
    // データを展開するアドレス
    u8 offset = (mark & 0x3f) * offsetScale;
    EggsData* target = (EggsData*) (defalutTarget + offset);
    
    // sourceはマークしたポケモンの次のポケモンを指す
    BoxPokemonAsData* source = (BoxPokemonAsData*)(selected + 1);
    u8 eggNum = source[0].header.eggNum;
    u32 size = sizeof(data68) * eggNum;


    // データを展開
    for (int i = 0; i < eggNum; i++)
    {
        decrypt(&source[i]);
        memcpy(&target->data[i], &source[i].data, sizeof(data68));
        encrypt(&source[i]);
    }

    // 実行
    if (source[0].header.isAutoRun == 1) {
        call((u32)target+1);
    }
}