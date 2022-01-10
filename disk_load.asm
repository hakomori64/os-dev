disk_load:
    ; ES:BXにセクター２（ブートセクターの次のセクタ）からDH個だけセクターを読み込む
    ; @params dh 読み込むセクター数
    ; @params dl 読み込むドライブ
    ; @params es 保存するセグメント
    ; @params bx 保存する位置
    pusha
    push dx

    mov ah, 0x02 ; BIOS read sector function
    mov al, dh ; dh個数だけ読む
    mov ch, 0x00 ; シリンダー０の
    mov dh, 0x00 ; ヘッダ０の
    mov cl, 0x02 ; 2セクタ目から

    int 0x13

    jc disk_error

    pop dx
    cmp dh, al ; alに実際に読み込んだセクタ数が入っている
    jne disk_error

    popa 
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    mov dx, ax
    call print_hex
    jmp $

DISK_ERROR_MSG:
    db "Disk read error!", 0