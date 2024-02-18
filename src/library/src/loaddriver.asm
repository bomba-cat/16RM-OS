;=======================================
        ;16RM-OS Load Driver made by
        ;xl-rl, ...
        ;Ver. 0.0.1
        ;Last Modified 18 Feb, 2024
        ;Last Modified by, xk-rl
;=======================================
        ;Load Driver Information
        ;Sector: 7
        ;Size: < 512 bytes
;=======================================

;---------------------------------------
;-------------------Load-Driver-Start---
        org 11000
        bits 16

        cmp al, 0
        je .load
        jne .unload

        jmp .load
;---------------------------------------
;--------------------------------Main---
.load:
        mov ah, 0x02
        mov al, 1
        int 0x10

        jmp bx

.unload:
        mov dx, 0
        mov es, ax
