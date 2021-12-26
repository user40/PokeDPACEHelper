from bin2par import *

def test_binToUints():
    assert binToUints(bytes(range(0,16))) == [0x03020100,0x07060504,0x0B0A0908,0x0F0E0D0C]

def test_uintToString():
    assert uintToString([0x01234567], False) == ["01234567"]

def test_align0():
    assert align(bytes([1,1,1])) == bytes([1,1,1,0])

def test_align1():
    assert align(bytes([1,1,1,1])) == bytes([1,1,1,1])