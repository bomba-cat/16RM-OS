;=======================================
        ;16RM-OS Read Driver made by
        ;xk-rl, ...
        ;Ver. 0.0.4
        ;Last Modified 12 Feb, 2024
        ;Last Modified by, xk-rl
;=======================================
        ;Read Driver Information
        ;Sector: 5
        ;Size: < 512 bytes
;=======================================

;---------------------------------------
;-------------------Read-Driver-Start---
        org 9000
        bits 16

        %define NEXL 0x0D, 0x0A
        jmp .read
;---------------------------------------
;-------------------------Load-Driver---
.echo:
        mov ah, 0x02
        mov al, 1
        mov cl, 6
        mov bx, 10000
        int 0x13
        
        jmp 10000
;---------------------------------------
;------------------Read-Keyboard-Keys---
.read:
                                        ; Read keyboard strokes and print to TTY
        mov cx, 0                       ; Counter to not overwrite any text made by echo driver
        mov bx, 0
        mov dx, 0
.loopread:
        mov ah, 0x0
        int 0x16

        cmp al, 13
        je .return

        cmp al, 8
        je .backspace

        inc cx

        cmp ah, 0x4B
        je .leftarrow

        cmp ah, 0x4D
        je .rightarrow

        mov ah, 0x0E
        mov bh, 0
        int 0x10

        mov [input+bx], al

        inc bx
        jmp .loopread

.rightarrow:
        mov bh, 0                       ; Add arrow key
        mov ah, 0x09
        int 0x10
        mov ah, 0x0E
        int 0x10
        jmp .loopread

.leftarrow:
        mov al, 8                       ; Add arrow key
        mov ah, 0x0E
        mov bh, 0
        int 0x10
        jmp .loopread

.return:
        mov si, nline                   ; Add return key functionality like used to
        call .echo
                                        ; Do some modification with our input before returning
        ;mov [input+bx], dx
        mov si, input
        
        ret

.backspace:
        cmp cx, 0
        je .loopread
        dec cx
        mov al, 8                       ; Add backspace key functionality like used to
        mov al, 8
        mov ah, 0x0E
        mov bh, 0
        int 0x10

        mov al, 32
        int 0x10

        mov al, 8
        int 0x10

        dec bx

        mov [input+bx], dx

        jmp .loopread
;---------------------------------------
;--------------------------------Data---
nline:                      
        db '', NEXL, 0

input:
        db '',
