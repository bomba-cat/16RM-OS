;=======================================
        ;16RM-OS Echo Driver made by
        ;xk-rl, ...
        ;Ver. 0.0.2
        ;Last Modified 11 Feb, 2024
        ;Last Modified by, xk-rl
;=======================================
        ;Echo Driver Information
        ;Sector: 6
        ;Size: < 512 bytes
;=======================================

;---------------------------------------
;-------------------Echo-Driver-Start---
        org 10000
        bits 16

        jmp .echo
;---------------------------------------
;--------------------------------Main---
.echo:
.loopecho:
        lodsb
        or al, al
        jz .finishedecho
        mov ah, 0x0E
        mov bh, 0
        int 0x10

        jmp .loopecho
.finishedecho:
        ret
