# プロジェクト目録
プロジェクトの種類が増えてきて何がなんやらわからなくなってきたので、それぞれの用途をまとめておく
### markingACE_entry
廃止。markingACEを起動するために、最初に入力するブートローダ。
### markingACE_entry_full
markingACEを起動する完全なブートローダ。```markingACE_setup```を実行するとこれが書き込まれる。
### markingACE_entry3
markingACEを起動するために、最初に入力するブートローダ。

中身は```pop {pc}```１命令だけ。
### markingACE_setup
```markingACE_entry_full```をメモリに書き込むためのプログラム。```markingACE_entry3```から呼び出される想定。
### markingACE_THUMB_switch
廃止。```markingACE_entry```を呼び出した後、最初に呼び出して使うセットアッププログラム。
### memory_editor
簡易メモリエディター
### memory_editor_essential
簡易メモリエディターの必要最低限の部分を取り出したもの
### pokecrypt
廃止。プログラムを暗号化してポケモンにつめこむ
### test_pokegram
pokegram用のサンプルコード