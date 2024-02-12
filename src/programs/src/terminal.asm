;=======================================
        ;Assembly Terminal made by
        ;xk-rl, ...
        ;Ver. 0.0.1
        ;Last Modified 12 Feb, 2024
        ;Last Modified by, xk-rl
;=======================================
        ;Terminal Information
        ;Sector: 10
        ;Size: < 512 bytes
;=======================================

;---------------------------------------
;----------------------Terminal-Start---
        org 20000
        bits 16

        %define NEXL 0x0D, 0x0A
        jmp .main
;---------------------------------------
;-------------------------Load-Driver---
.loaddriver:
        mov ah, 0x02
        mov al, 1
        int 0x13

        jmp bx
;---------------------------------------
;--------------------------------Main---
.main: 
        mov si, tty
        mov cl, 6
        mov bx, 10000
        call .loaddriver

        mov cl, 5
        mov bx, 9000
        call .loaddriver

        ret

;---------------------------------------
;--------------------------------Data---
tty:
        db '16RM-TTY-> ', 0

clear:
        db ' ', NEXL, 0
