; ブートセクター
; BIOSがデバイスを検索して回って最初の512バイトを見て0xaa55で終わっているものをブートセクターとする
; ハードディスクからメモリの0x7c00に読み込まれることが多い
; print character (ah = 0x0e, al = character, int 0x10)

mov ah, 0x0e

mov al, the_secret
int 0x10

mov al, [the_secret] ; the_secretはセクターの先頭からのインデックスであるのに対し、メモリの読み書きはメモリのスタートからカウントされるので合わない
; コードの先頭に[org 0x7c00]と入れるとラベル全てにこのオフセットを追加してくれるので正常に動作するようになる。
int 0x10

mov bx, the_secret
add bx, 0x7c00 ; コードが読み込まれる位置 + コードの先頭からの文字列までの距離
mov al, [bx]
int 0x10

mov al, [0x7c1d] ; アセンブル済のコードから文字列が0x1dにあると判断したので、0x7c00 + 0x1dで0x7c1d
int 0x10


jmp $

the_secret:
    db "X"

times 510 - ($ - $$) db 0

dw 0xaa55