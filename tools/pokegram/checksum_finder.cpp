#include "checksum_finder.h"

using namespace std;

ChecksumFinder ChecksumFinder::fromBinary(vector<char> binary) {
    if ( binary.size() < sizeof(data.abcd) ) {
        ChecksumFinder cf(binary);
        return cf;
    } else {
        throw invalid_argument("Binary size is too large.");
    }
}

bool ChecksumFinder::findAndSet() {
    for (int i = 0; i < 0x100; i++) {
        data.abcd[raw_size] = i;
        if ( data.setValidChecksum() ) {
            return true;
        }
    }
    return false;
}

bool ChecksumFinder::isSmallEnough(size_t size) {
    return size < sizeof(ABCD);
}

vector<char> ChecksumFinder::getData() {
    vector<char> v(getTotalSize());
    memcpy(&v[0], &data, v.size());
    return v;
}


ChecksumFinder::ChecksumFinder(vector<char> binary) {
    data = {};
    data.encrypt();
    data.isDametamago = true;

    raw_size = binary.size();
    size = align(raw_size);

    for (int i=0; i < binary.size(); i++) {
        data.abcd[i] = binary[i];
    }

    for (int i=binary.size(); i < size; i++) {
        data.abcd[i] = 0;
    }
}

size_t ChecksumFinder::align(size_t size) {
    return 4 + (size / 4) * 4;
}