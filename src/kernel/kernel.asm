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

    mov si, keyboard_enabled
    call .echo

    
    mov ah, 0x02
    mov al, 1
    mov cl, 3
    mov bx, 0x9000
    int 0x13

    jmp 0x9000

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
