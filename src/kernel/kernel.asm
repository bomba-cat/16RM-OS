; Kernel start
org 0x8000
; Using 16 bit for now
bits 16

%define NEXL 0x0D, 0x0A

jmp .main

.echo:
    ; Print to TTY
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
    ; Read keyboard strokes and print to TTY
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

    cmp ah, 0x4B
    je .leftarrow

    cmp ah, 0x4D
    je .rightarrow

    mov ah, 0x0E
    mov bh, 0
    int 0x10
    jmp .loopread

.rightarrow:
    ; Add arrow key
    mov bh, 0
    mov ah, 0x09
    int 0x10
    mov ah, 0x0E
    int 0x10
    jmp .loopread

.leftarrow:
    ; Add arrow key
    mov al, 8
    mov ah, 0x0E
    mov bh, 0
    int 0x10
    jmp .loopread

.return:
    ; Add return key functionality like used to
    mov si, nline
    call .echo
    jmp .loopread

.backspace:
    ; Add backspace key functionality like used to
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

    ;call .read

    mov si, keyboard_failed
    call .echo

.hlt:
    ; Set CPU in an infinite idling state
    cli
    hlt
    jmp .hlt

nline:              db '', NEXL, 0
loaded:             db '[ SUCCESS ]   Loaded the Kernel!', NEXL, 0
keyboard:           db '[ JOB ]       Enabling keyboard...', NEXL, 0
keyboard_enabled:   db '[ SUCCESS ]   Keyboard enabled!', NEXL, 0
keyboard_failed:    db '[ FAILED ]    Could not activate Keyboard or skipped by Kernel!', NEXL, 0
