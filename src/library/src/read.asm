; 16 Bit real mode for bios interrupt
;org 0x9000
bits 16

%define NEXL 0x0D, 0x0A

jmp .read

; Temporary, didnt add echo driver yet
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

nline:                      db '', NEXL, 0
