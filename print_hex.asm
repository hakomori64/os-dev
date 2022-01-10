[org 0x7c00]

print_hex:
    ; @params dx: 2 bytes to print
    pusha

    mov cx, 0
    call print_hex_loop

print_hex_loop:
    cmp cx, 0x0004
    je print_hex_fin

    mov ax, dx
    and ax, 0x000f

    cmp ax, 10
    jl print_hex_number

    add ax, 'A'
    sub ax, 10

    jmp print_hex_loop_post_process

print_hex_loop_post_process:
    ; insert bl
    mov bx, HEX_OUT
    add bx, 5
    sub bx, cx
    mov [bx], al
    shr dx, 4
    add cx, 1
    jmp print_hex_loop

print_hex_number:
    add ax, '0'
    jmp print_hex_loop_post_process


print_hex_fin:
    mov bx, HEX_OUT
    call print_string
    popa
    ret

HEX_OUT:
    db '0x0000', 0