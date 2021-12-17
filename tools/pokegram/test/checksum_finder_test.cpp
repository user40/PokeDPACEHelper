#include <gtest/gtest.h>
#include "../checksum_finder.h"

TEST(ChecksumFinder, Buizeru) {
    auto fpath = "./testfile/buizeru.bin";
    auto cf = ChecksumFinder::fromFile(fpath);
    EXPECT_FALSE(!cf);

    EXPECT_TRUE(cf.findAndSet());
    EXPECT_EQ(cf.getBoxdata().isDametamago, true);
    EXPECT_EQ(cf.getBoxdata().checksum, 0xAFE8);
}

TEST(ChecksumFinder, Empty) {
    auto fpath = "./testfile/empty_pokemon.bin";
    auto cf = ChecksumFinder::fromFile(fpath);
    EXPECT_FALSE(!cf);

    EXPECT_TRUE(cf.findAndSet());
    EXPECT_EQ(cf.getBoxdata().isDametamago, true);
    EXPECT_EQ(cf.getBoxdata().checksum, 0);
}