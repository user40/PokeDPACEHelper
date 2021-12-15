from typing import List

class ByteWriterScript:
    def fromParCodes(codes: List[str], dec=False, nozero=False) -> List[str]:
        result = []
        for code in codes:
            for script in ByteWriterScript.fromParCode(code, nozero):
                if dec:
                    result.append(f"{script:d}")
                else:
                    result.append(f"{script:16x}")
        return result
        
    def fromParCode(code: str, nozero: bool) -> List[int]:
        result = []
        if code == "":
            return result
        address = int(code.split()[0], 16)
        value = int(code.split()[1], 16)
        bytes = splitToBytes(value)
        for i, byte in enumerate(bytes):
            if nozero and (byte == 0):
                continue
            script = ByteWriterScript.toLoadAdrsVal(address + i, byte)
            result.append(script)
        return result
    
    def toLoadAdrsVal(address: int, value: int) -> str:
        return 0x0200000000000007 + address*0x10000 + value*0x1000000000000


def splitToBytes(word: int) -> List[int]:
    bytes = [0]*4
    bytes[0] = (word & 0x000000FF)
    bytes[1] = (word & 0x0000FF00) >> 8
    bytes[2] = (word & 0x00FF0000) >> 16
    bytes[3] = (word & 0xFF000000) >> 24
    return bytes
