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

.main:
    mov si, loaded
    call .echo

    mov si, keyboard
    call .echo

    ;call .read

    mov si, keyboard_enabled
    call .echo

    

    ;mov si, keyboard_failed
    ;mov bx, 4h
    ;call .echo

; data
loaded:                             db ' SUCCESS   Loaded the Kernel!', NEXL, 0
keyboard:                           db '     JOB   Enabling keyboard, type something and hit enter', NEXL, 0
keyboard_enabled:                   db ' SUCCESS   Keyboard enabled!', NEXL, 0
keyboard_failed:                    db '  FAILED   Could not activate Keyboard or skipped by Kernel!', NEXL, 0
wait_for_keypress_message:          db '    INFO   Press any key to Reboot', 0
bdb_sectors_per_track:              dw 18
bdb_head:                           dw 2
floppy_error:                       db 'CRITICAL   Could not read from Floppy!', NEXL, 0

.hlt:
    ; Set CPU in an infinite idling state
    cli
    hlt
    jmp .hlt

.floppy_error:
    mov si, floppy_error
    call .echo
.wait_and_reboot:
    mov si, wait_for_keypress_message
    call .echo
    mov ah, 0
    int 16h
    jmp 0FFFFh:0

.lba_to_chs:
    push ax
    push dx

    xor dx, dx
    div word [bdb_sectors_per_track]
    inc dx
    mov cx, dx
    xor dx, dx
    div word [bdb_head]
    mov dh, dl
    mov ch, al
    shl ah, 6
    or cl, ah

    pop ax
    mov dl, al
    pop ax
    ret

.diskread:
    push ax
    push bx
    push cx
    push dx
    push di

    push cx
    call .lba_to_chs
    pop ax
    mov ah, 02h
    mov di, 3

.retry:
    pusha
    stc
    int 13h
    jnc .finishdiskread

    popa
    call .disk_reset

    dec di
    test di, di
    jnz .retry
.fail:
    jmp .floppy_error

.finishdiskread:
    popa

    pop di
    pop dx
    pop cx
    pop bx
    pop ax

    ret
    
.disk_reset:
    pusha
    mov ah, 0
    stc
    int 13h
    jc .floppy_error
    popa
    ret
