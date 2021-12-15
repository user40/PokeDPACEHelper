#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

using u16 = unsigned short;
using u32 = unsigned int;
using ABCD = unsigned char[0x80];

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
    inline u32 nextRand(u32 rand) { return rand * 1103515245L + 24691; }
    inline u16 mask(u16 data, u32 key) { return data ^ (key >> 16); }
};

string outputPath(char* inputPath);

int main(int argc, char *argv[]){
    if(argc <= 1) {
        cerr << "No commandline arguments" << endl;
        exit( EXIT_FAILURE );
    }

    // ボックス内の空欄と同じになるよう初期化しておく
    boxdata data = {};
    data.encrypt();

    ifstream ifs(argv[1], ios::binary);
    if(!ifs) {
        cerr << "Failed to open file " << argv[1] << endl;
        exit(1);
    }

    // ファイルサイズが0x80より大きい場合はエラー
    ifs.seekg(0, ios::end);
    size_t size = ifs.tellg();
    if( size > sizeof(data) ) {
        cerr << "Invalid file size " << hex << size << endl;
        cerr << "It should be less than or equal 0x80 byte." << endl;
        exit(1);
    }

    // 読み込んだデータをABCDの頭から上書きする
    ifs.seekg(0, ios::beg);
    ifs.read((char*) data.abcd, size);

    // 有効なチェックサムを計算する。見つからなければエラー
    if ( !data.setValidChecksum() ) {
        cerr << "No checksum founds" << endl;
        exit(1);
    }

    // ダメタマゴにして出力
    data.isDametamago = true;
    string out = outputPath(argv[1]);
    ofstream ofs(out, ios::binary);
    ofs.write((char*) &data, size + 8);
}

string outputPath(char* inputPath) {
    string out = string(inputPath);
    int ext_i = out.find_last_of(".");
    return out.substr(0, ext_i) + "_poke.bin";
}

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
