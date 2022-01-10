print_string:
    ; @params bx: 文字列のポインタ
    pusha

    mov ah, 0x0e
    jmp print_string_loop

print_string_loop:
    mov dl, [bx]
    cmp dl, 0x00
    je print_string_fin
    mov al, [bx]
    int 0x10
    add bx, 1
    jmp print_string_loop

print_string_fin:
    popa
    ret