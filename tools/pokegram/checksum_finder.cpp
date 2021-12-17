#include "checksum_finder.h"

using namespace std;

ChecksumFinder ChecksumFinder::fromFile(string fpath) {
    ifstream ifs(fpath, ios::binary);
    if(!ifs) {
        return ChecksumFinder();
    }

    // ファイルサイズ取得
    ifs.seekg(0, ios::end);
    size_t size = ifs.tellg();

    // vectorにバイナリのデータを読み出し
    vector<char> bin(size);
    ifs.seekg(0, ios::beg);
    ifs.read(&bin[0], size);

    return ChecksumFinder(bin);
}

ChecksumFinder ChecksumFinder::fromBinary(vector<char> binary) {
    if ( binary.size() < sizeof(data.abcd) ) {
        ChecksumFinder cf(binary);
        return cf;
    } else {
        throw invalid_argument("Binary size is too large.");
    }
}

bool ChecksumFinder::findAndSet() {
    // サイズに余裕がある場合は未使用領域を書き換えながら試行を繰り返す
    if (raw_size < sizeof(ABCD)) {
        for (int i = 0; i < 0x100; i++) {
            data.abcd[raw_size] = i;
            if ( data.setValidChecksum() ) {
                return true;
            }
        }
    // サイズに余裕がない場合はデータを書き換えず一度だけ試行する
    } else {
        if ( data.setValidChecksum() ) {
            return true;
        }
    }
    return false;
}

bool ChecksumFinder::isSmallEnough(size_t size) {
    return size < sizeof(ABCD);
}

vector<char> ChecksumFinder::getDataAsVector() {
    vector<char> v(getTotalSize());
    memcpy(&v[0], &data, v.size());
    return v;
}

vector<char> ChecksumFinder::getBoxdataAsVector() {
    vector<char> v(sizeof(boxdata));
    memcpy(&v[0], &data, sizeof(boxdata));
    return v;    
}


bool ChecksumFinder::operator !() {
    return size < 0;
}


ChecksumFinder::ChecksumFinder() {
    data = {};
    raw_size = 0;
    size = -1;
}

ChecksumFinder::ChecksumFinder(vector<char> binary) {
    data = {};
    data.encrypt();
    data.isDametamago = true;

    raw_size = binary.size();

    if ( raw_size < sizeof(ABCD) ) {
        size = align(raw_size);
        
        for (int i=0; i < binary.size(); i++) {
        data.abcd[i] = binary[i];
        }

        for (int i=binary.size(); i < size; i++) {
            data.abcd[i] = 0;
        }
    } else if ( raw_size == sizeof(ABCD) ) {
        for (int i=0; i < binary.size(); i++) {
            data.abcd[i] = binary[i];
        }
        size = raw_size;
    } else {
        size = -1;
    }
}

size_t ChecksumFinder::align(size_t size) {
    return 4 + (size / 4) * 4;
}