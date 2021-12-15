#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include "common.h"
#include "boxdata.h"
#include "checksum_finder.h"

using namespace std;

string outputPath(char* inputPath);

int main(int argc, char *argv[]){
    if(argc <= 1) {
        cerr << "No commandline arguments" << endl;
        exit( EXIT_FAILURE );
    }

    ifstream ifs(argv[1], ios::binary);
    if(!ifs) {
        cerr << "Failed to open file " << argv[1] << endl;
        exit(1);
    }

    // ファイルサイズが0x80以上の場合はエラー
    ifs.seekg(0, ios::end);
    size_t size = ifs.tellg();
    if( size >= sizeof(ABCD) ) {
        cerr << "Invalid file size " << hex << size << endl;
        cerr << "It should be less than 0x80 byte." << endl;
        exit(1);
    }

    // vectorにバイナリのデータを読み出し
    vector<char> bin(size);
    ifs.seekg(0, ios::beg);
    ifs.read(&bin[0], size);

    auto cf = ChecksumFinder::fromBinary(bin);

    // 有効なチェックサムを計算する。見つからなければエラー
    if ( !cf.findAndSet() ) {
        cerr << "No checksum founds" << endl;
        exit(1);
    }

    // 出力
    string out = outputPath(argv[1]);
    ofstream ofs(out, ios::binary);
    auto data = cf.getData();
    ofs.write(&data[0], data.size());
}

string outputPath(char* inputPath) {
    string out = string(inputPath);
    int ext_i = out.find_last_of(".");
    return out.substr(0, ext_i) + "_poke.bin";
}

