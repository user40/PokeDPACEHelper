# プロジェクト目録
プロジェクトの種類が増えてきて何がなんやらわからなくなってきたので、それぞれの用途をまとめておく
### markingACE_init_full
markingACEを起動するためのパッチ。マーキングで決定を押したときに実行され、マーキングしたポケモン（平文）の+8バイト目にジャンプする。毎回手で入力するには長いため、```markingACE_init_short```と```markingACE_setup```を組み合わせてパッチする。
### markingACE_init_short
markingACEを起動するためのパッチ。full版をパッチするための起点として使う。

使用法は
1. 電卓でこのパッチを手入力
2. ```markingACE_setup```を書き込んだポケモンにマーキングを施す
を想定。


中身は```pop {pc}```１命令だけ。
### markingACE_setup
```markingACE_init_full```をパッチする。
使用法は```markingACE_init_short```を参照。

### memory_editor
簡易メモリエディター
### memory_editor_essential
簡易メモリエディターの必要最低限の部分を取り出したもの
### cryptegg
プログラムを暗号化してポケモンにつめこむ

## old
もう使っていないプロジェクト
### markingACE_THUMB_switch
```markingACE_entry```を呼び出した後、最初に呼び出して使うセットアッププログラム。
### markingACE_entry
markingACEを起動するために、最初に入力するブートローダ。
### test_pokegram
pokegram用のサンプルコード