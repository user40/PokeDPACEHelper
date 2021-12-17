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

    auto cf = ChecksumFinder::fromFile(argv[1]);
    if (!cf) {
        cerr << "Failed to open file " << argv[1] << endl;
        exit(1);
    }

    // 有効なチェックサムを計算する。見つからなければエラー
    if ( !cf.findAndSet() ) {
        cerr << "No checksum founds" << endl;
        exit(1);
    }

    // 出力
    auto data = cf.getDataAsVector();
    
    string out = outputPath(argv[1]);
    ofstream ofs(out, ios::binary);
    ofs.write(&data[0], data.size());
}

string outputPath(char* inputPath) {
    string out = string(inputPath);
    int ext_i = out.find_last_of(".");
    return out.substr(0, ext_i) + "_poke.bin";
}

