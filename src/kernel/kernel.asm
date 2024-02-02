org 0x8000
bits 16

%define NEXL 0x0D, 0x0A

jmp short start

start:
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

.main:
    mov ax, 0
    mov dx, ax
    mov es, ax

    mov ss, ax
    mov sp, 0x7C00

    mov si, loaded
    call .echo

loaded: db 'Loaded the Kernel!', NEXL, 0
