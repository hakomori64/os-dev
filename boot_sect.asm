[org 0x7c00]

    mov [BOOT_DRIVE], dl

    mov bp, 0x8000 ; stack setup
    mov sp, bp

    mov bx, 0x9000 ; load 5 sectors to 0x0000(ES):0x9000
    mov dh, 5
    mov dl, [BOOT_DRIVE]
    call disk_load

    mov dx, [0x9000]
    call print_hex ; 0xdada

    mov dx, [0x9000 + 512]
    call print_hex ; 0xface

    jmp $

%include "print_string.asm"
%include "print_hex.asm"
%include "disk_load.asm"

; Data
BOOT_DRIVE: db 0

times 510 - ($ - $$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface

times 768 dw 0xdead