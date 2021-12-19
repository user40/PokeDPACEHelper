// データをポケモンに詰め込み暗号化し、バイナリファイルとして出力
// 出力ファイル名は"*_poke0.bin"

#include "../pokegram/common.h"
#include "../pokegram/boxdata.h"

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace std;

string outputPath(char* inputPath);

int main(int argc, char *argv[]){
    if(argc <= 1) {
        cerr << "No commandline arguments" << endl;
        exit( EXIT_FAILURE );
    }

    boxdata data = {};

    ifstream ifs(argv[1], ios::binary);
    if(!ifs) {
        return -1;
    }

    // ファイルサイズ取得
    ifs.seekg(0, ios::end);
    size_t size = ifs.tellg();
    if (size > sizeof(ABCD)){
        return -1;
    }

    // バイナリのデータを読み出し
    ifs.seekg(0, ios::beg);
    ifs.read((char*) &data.abcd, size);

    // 暗号化
    data.forceEncrypt();
    data.pid = 0x00006000;      // shuffle type 3
    data.isDametamago = true;

    // 出力
    string out = outputPath(argv[1]);
    ofstream ofs(out, ios::binary);
    ofs.write((char*) &data, sizeof(boxdata));
}

string outputPath(char* inputPath) {
    string out = string(inputPath);
    int ext_i = out.find_last_of(".");
    return out.substr(0, ext_i) + "_poke0.bin";
}

