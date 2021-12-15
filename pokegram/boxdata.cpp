#include "boxdata.h"

void boxdata::encrypt()
{
    u16* data = (u16*) abcd;
    u32 rand = checksum;
	for(int i = 0; i < sizeof(ABCD)/2 ; i++ ){
        rand = nextRand(rand);
		data[i] = mask(data[i], rand);
	}
}

/**
 * @return 成功: true, 失敗: false;
 */
bool boxdata::setValidChecksum()
{
    for (int i=0; i < 0x10000; i++) {
        if( calcChecksum(i) == i) {
            checksum = i;
            return true;
        }
    }
    return false;
}

u16 boxdata::calcChecksum(u16 seed)
{
    u16* data = (u16*) abcd;
	u16	checksum = 0;
    u32 rand = seed;

	for(int i = 0; i < sizeof(ABCD)/2 ; i++ ){
        rand = nextRand(rand);
		checksum += mask(data[i], rand);
	}

	return checksum;
}