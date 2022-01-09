; ブートセクター
; BIOSがデバイスを検索して回って最初の512バイトを見て0xaa55で終わっているものをブートセクターとする
; ハードディスクからメモリの0x7c00に読み込まれることが多い
; print character (ah = 0x0e, al = character, int 0x10)

mov ah, 0x0e

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10

jmp $

times 510 - ($ - $$) db 0

dw 0xaa55