#ifndef CHECKSUM_FINDER_H
#define CHECKSUM_FINDER_H

#include <stdlib.h>
#include <string.h>
#include <fstream>
#include <stdexcept>
#include <vector>
#include "boxdata.h"

class ChecksumFinder{
    boxdata data;
    size_t raw_size;    // アラインメントを揃える前のサイズ
    size_t size;        // アラインメントを揃えた後のサイズ

    public:
        static ChecksumFinder fromFile(std::string fpath);
        static ChecksumFinder fromBinary(std::vector<char> binary);
        static bool isSmallEnough(size_t size);
        bool findAndSet();
        std::vector<char> getDataAsVector();
        std::vector<char> getBoxdataAsVector();
        boxdata& getBoxdata();
        size_t getRawSize();
        size_t getTotalSize();
        bool operator !();

    protected:
        ChecksumFinder();
        ChecksumFinder(std::vector<char> binary);
        static size_t align(size_t size);
};


inline boxdata& ChecksumFinder::getBoxdata() { return data; }
inline size_t ChecksumFinder::getRawSize() { return raw_size; }
inline size_t ChecksumFinder::getTotalSize() { return size + 8; }

#endif // CHECKSUM_FINDER_H
