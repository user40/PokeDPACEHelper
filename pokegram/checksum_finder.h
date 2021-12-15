#ifndef CHECKSUM_FINDER_H
#define CHECKSUM_FINDER_H

#include <stdlib.h>
#include <string.h>
#include <stdexcept>
#include <vector>
#include "boxdata.h"

class ChecksumFinder{
    boxdata data;
    size_t raw_size;    // アラインメントを揃える前のサイズ
    size_t size;        // アラインメントを揃えた後のサイズ

    public:
        static ChecksumFinder fromBinary(std::vector<char> binary);
        static bool isSmallEnough(size_t size);
        bool findAndSet();
        char* getDataPointer();
        std::vector<char> getData();
        size_t getRawSize();
        size_t getTotalSize();

    private:
        ChecksumFinder(std::vector<char> binary);
        static size_t align(size_t size);
};


inline char* ChecksumFinder::getDataPointer() { return (char*) &data; }
inline size_t ChecksumFinder::getRawSize() { return raw_size; }
inline size_t ChecksumFinder::getTotalSize() { return size + 8; }

#endif // CHECKSUM_FINDER_H
