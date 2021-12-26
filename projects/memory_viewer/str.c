typedef unsigned char u8;
typedef unsigned short u16;
typedef unsigned int u32;
typedef u16 STRCODE;
typedef struct _STRBUF STRBUF;
typedef struct _GF_BGL_INI	GF_BGL_INI;

typedef int* pStrPrintCallBack;

#define ZERO 0xa2
#define HEAPID_BASE_DEBUG 2
#define NULL ((void*)0)

#define STRBUF_Create(a, b) ((STRBUF* (*)(u32, u32))0x02023131)(a, b)
#define BmpMenuWinWrite(a, b, c, d) ((void (*)(GF_BGL_BMPWIN*, int, int, int))0x0200e709)(a, b, c, d)
#define GF_STR_PrintSimple(a, b, c, d, e, f, g) ((u8 (*)(GF_BGL_BMPWIN*, u32, const STRBUF*, u32, u32, u32, pStrPrintCallBack))0x0201ce65)(a, b, c, d, e, f, g)

struct _STRBUF {
    u8 dummy[8];
	STRCODE  buffer[1];
};

typedef struct {
    u8 dummy[16];
}GF_BGL_BMPWIN;

inline u32 toStrcode(u8 num) {
    u8 low = num & 0xF;
    u8 high = num >> 8;
    return (high+ZERO) + (low+ZERO)<<16;
}

inline void toStrcodeBuff(u8 nums[], u32 buff[]) {
    int size = sizeof(GF_BGL_BMPWIN);
    const int max = 32;
    for (int i=0; i<max; i++){
        buff[i] = toStrcode(nums[i]);
    }
}

int func() {
    STRBUF * buff;
    GF_BGL_BMPWIN win;
    // GF_BGL_BMPWIN の初期化
    // ...
    buff = STRBUF_Create(10, HEAPID_BASE_DEBUG);
    buff->buffer[0] = 0xa2;
    buff->buffer[1] = 0xFFFF;
    GF_STR_PrintSimple(&win, 0, buff, 0, 16, 0xff, NULL);
    BmpMenuWinWrite(&win, 1, 1024-9, 14);
}