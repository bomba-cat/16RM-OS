org 0x8000
bits 16

%define NEXL 0x0D, 0x0A

jmp .main

.echo:
    push si
    push ax
.loopecho:
    lodsb
    or al, al
    jz .finishedecho
    mov ah, 0x0E
    mov bh, 0
    int 0x10
    
    jmp .loopecho
.finishedecho:
    pop ax
    pop si
    ret

.read:
    mov si, keyboard_enabled
    call .echo
    push si 
    push ax
.loopread:
    mov ah, 0x0
    int 0x16

    cmp al, 13
    je .return

    cmp al, 8
    je .backspace

    mov ah, 0x0E
    mov bh, 0
    int 0x10
    jmp .loopread

.return:
    mov si, nline
    call .echo
    jmp .loopread

.backspace:
    mov al, 8
    mov ah, 0x0E
    mov bh, 0
    int 0x10

    mov al, 32
    int 0x10

    mov al, 8
    int 0x10

    jmp .loopread

.main:
    mov si, loaded
    call .echo

    mov si, keyboard
    call .echo

    call .read

.hlt:
    cli
    hlt
    jmp .hlt

nline:              db '', NEXL, 0
loaded:             db '[ SUCCESS ]   Loaded the Kernel!', NEXL, 0
keyboard:           db '[ JOB ]       Enabling keyboard...', NEXL, 0
keyboard_enabled:   db '[ SUCCESS ]   Keyboard enabled!', NEXL, 0
