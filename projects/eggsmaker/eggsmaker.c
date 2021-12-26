/*
* eggloader用のタマゴ作成するプログラム
*/

#include "dpstdlib.h"
#include "eggcommon.h"

#define defalutTarget 0x02290000
#define offsetScale 0x100

/**
 * @brief メモリ上のデータを分割し、複数のタマゴに保存する。
 * 使用者はeggNumとisAutoRunを事前にセットしておくこと。
 * @param selected 
 * @param dummy1 
 * @param dummy2 
 * @param mark 読み込みオフセット(+mark*0x100)
 * @details アドレス (0x02290000 + mark*0x100) にあるデータを参照する。
 * 
 */
void MakeEgg(BoxPokemon* selected, u32 dummy1, u32 dummy2, u8 mark) {
    u8 offset = (mark & 0x3F) * offsetScale;
    // マークされたポケモンの次のポケモン
    BoxPokemonAsData* target = (BoxPokemonAsData*) (selected + 1);
    EggsData* source = (EggsData*) (defalutTarget + offset);
    u8 eggNum = source->header.eggNum;

    // データをコピー
    target[0].header.eggNum = eggNum;
    target[0].header.isAutoRun = source->header.isAutoRun;
    for (int i = 0; i < eggNum; i++)
    {
        memcpy(&target[i].data, &source->data[i], sizeof(data68));
        target[i].header.isBadEgg = 1;
        target[i].header.isEncrypted1 = 1;
        target[i].header.dummy[0] = 0x60;       // pid 0x00006000 = shuffle type 3
        encrypt((BoxPokemon*) &target[i]);
    }
}