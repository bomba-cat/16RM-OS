org 0x8000
bits 16

%define NEXL 0x0D, 0x0A

jmp .main

.echo:
    push si
    push ax
.loop:
    lodsb
    or al, al
    jz .finishedecho
    mov ah, 0x0E
    mov bh, 0
    int 0x10
    
    jmp .loop
.finishedecho:
    pop ax
    pop si
    ret

.main:
    mov ax, 0
    mov dx, ax
    mov es, ax

    mov ss, ax
    mov sp, 0x8000

    mov si, loaded
    call .echo

.hlt:
    cli
    hlt
    jmp .hlt

loaded: db 'Loaded the Kernel!', NEXL, 0
