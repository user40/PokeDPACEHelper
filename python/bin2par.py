import struct
from typing import List
from par2writeByteScript import *

class bin2Text:
    def __init__(self, fpath, address=0, pointer=0) -> None:
        self.uints = binOpen(fpath)
        self.address = address
        self.pointer = pointer
    
    def toString(self, dec=False):
        return uintToString(self.uints, dec)

    def toWordWriteParCode(self, nozero=False) -> List[str]:
        return fourBytesWriteCode(self.uints, self.address, nozero)

    def toWordWritePointerParCode(self) -> List[str]:
        return fourBytesWritePointerCode(self.uints, self.pointer, self.address)

    def toByteWriteScript(self, dec=False, nozero=False) -> List[str]:
        parCode = self.toWordWriteParCode(nozero)
        return ByteWriterScript.fromParCodes(parCode, dec, nozero)


def binOpen(fpath) -> List[int]:
    with open(fpath, "rb") as f:
        return binToUints(f.read())

def binToUints(bytes: bytes) -> List[bytes]:
    l = []
    while len(bytes) > 0:
        four = bytes[:4]
        l.append(struct.unpack("<I", four)[0])
        bytes = bytes[4:]
    return l

def uintToString(uints: List[int], dec: bool) -> List[str]:
    result = []
    for uint in uints:
        if dec:
            result.append(f"{uint:d}")
        else:
            result.append(f"{uint:08X}")
    return result

def fourBytesWriteCode(units: List[int], startAddress: int, nozero: bool) -> List[str]:
    code = []
    for offset, uint in enumerate(units):
        if nozero and (uint == 0):
            continue
        address = startAddress + offset*4
        code.append(f"{address:08X} {uint:08X}")
    return code

def fourBytesWritePointerCode(units: List[int], pointer: int, offset: int) -> List[str]:
    code = []
    for step, uint in enumerate(units):
        line1 = f"B{pointer:07X} 00000000"
        line2 = f"{offset + step*4:08X} {uint:08X}"
        line3 = f"D2000000 00000000"
        code.extend([line1, line2, line3])
    return code