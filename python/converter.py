usage = '''
バイナリファイルをPARコード等に変換します。
オプション:
  -i                入力するバイナリファイルのパス
  -o                出力するファイルのパス
  -a                バイナリを配置するアドレス
  --mode=par        バイナリを書き込むPARコードを出力
  --mode=word       バイナリをワード(4byte)に切り分けて出力（16進法）
  --mode=wordDec    バイナリをワード(4byte)に切り分けて出力（10進法）
  --mode=script     バイナリをメモリに書き込むゲーム内スクリプト(..0007)を出力（16進法）
  --mode=scriptDec  バイナリをメモリに書き込むゲーム内スクリプト(..0007)を出力（10進法）
  --mode=csv        未実装
'''

from bin2par import *
from par2writeByteScript import *
import sys
import enum
from collections import deque
from typing import List

def main():
    option = parse(sys.argv[1:])
    bin = bin2Text(option.inputPath, option.address)
    with open(option.outputPath, 'w', encoding='utf-8', newline='\n') as f:
        if option.mode == Mode.par:
            f.writelines("\n".join(bin.toWordWriteParCode()))
        elif option.mode == Mode.word:
            f.writelines("\n".join(bin.toString(dec=False)))
        elif option.mode == Mode.wordDec:
            f.writelines("\n".join(bin.toString(dec=True)))
        elif option.mode == Mode.script:
            f.writelines("\n".join(bin.toByteWriteScript(dec=False)))
        elif option.mode == Mode.scriptDec:
            f.writelines("\n".join(bin.toByteWriteScript(dec=True)))
        elif option.mode == Mode.csv:
            pass
        else:
            raise Exception()


class Mode(enum.Enum):
    par = 'par'
    word = 'word'
    wordDec = 'wordDec'
    script = "script"
    scriptDec = 'scriptDec'
    csv = 'csv'

class Option:
    def __init__(self, 
        inputPath="",
        outputPath="",
        address="0",
        mode=Mode.par,
        ):
        self.inputPath = inputPath
        self.outputPath = outputPath
        self.address = int(address, 16)
        self.mode = mode
    
    def setAddress(self, address):
        self.address = int(address, 16)


def parse(args: List[str]) -> Option:
    if len(args) == 0:
        print(usage)
        exit(0)

    option = Option()
    argument_from_queue = deque(args)
    while argument_from_queue:
        argument = argument_from_queue.popleft()
        if argument in ['-h', '--help']:
            print(usage)
            sys.exit(0)
        elif argument == '-i':
            option.inputPath = argument_from_queue.popleft()
        elif argument == '-o':
            option.outputPath = argument_from_queue.popleft()
        elif argument == '-a':
            option.setAddress(argument_from_queue.popleft())
        elif argument == '--mode=par':
            option.mode = Mode.par
        elif argument == '--mode=word':
            option.mode = Mode.word
        elif argument == '--mode=wordDec':
            option.mode = Mode.wordDec
        elif argument == '--mode=script':
            option.mode = Mode.script
        elif argument == '--mode=scriptDec':
            option.mode = Mode.scriptDec
        elif argument == '--mode=csv':
            option.mode = Mode.csv
        else:
            print(f"Bad argument '{argument}'")
            print("With '-h' option to show usage")
            sys.exit(0)

    return option

if __name__ == "__main__":
    main()