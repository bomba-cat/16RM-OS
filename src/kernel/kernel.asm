;---------------------------------------        
;-------------Kernel start--------------
        org 0x8000
        bits 16
        
        %define NEXL 0x0D, 0x0A
        jmp .main
;---------------------------------------
.echo:
        ; Print to TTY
        push si
        push ax
.loopecho:
        lodsb
        or al, al
        jz .finecho
        mov ah, 0x0E
        mov bh, 0
        int 0x10
    
        jmp .loopecho
.finecho:
        pop ax
        pop si
        ret
;---------------------------------------
.main:
        mov si, loaded
        call .echo

        mov si, kb
        call .echo

        mov si, kb_on
        call .echo

    
        mov ah, 0x02
        mov al, 1
        mov cl, 3
        mov bx, 0x9000
        int 0x13

        jmp 0x9000

        ;mov si, kb_fail
        ;mov bx, 4h
        ;call .echo
;--------------------------------------
;----------------data------------------
loaded: 
        db ' SUCCESS   Loaded the Kernel!', NEXL, 0

kb:     
        db '     JOB   Enabling keyboard, type something and hit enter', NEXL, 0

kb_on:  
        db ' SUCCESS   Keyboard enabled!', NEXL, 0

kb_fail:
        db '  FAILED   Could not activate Keyboard or skipped by Kernel!', NEXL, 0
;--------------------------------------
.hlt:
        ; Set CPU in an infinite idling state
        cli
        hlt
        jmp .hlt
