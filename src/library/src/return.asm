;=======================================
        ;16RM-OS Return Driver made by
        ;xk-rl, ...
        ;Ver. 0.0.2
        ;Last Modified 11 Feb, 2024
        ;Last Modified by, xk-rl
;=======================================
        ;Return Driver Information
        ;Sector: 3
        ;Size: < 512 bytes
;=======================================

;---------------------------------------
;-----------------Return-Driver-Start---
        org 9000
        bits 16
        
        jmp .return
;---------------------------------------
;--------------------------------Main---
.return:
                                        ; Implement message saying "Returning to Kernel"
        mov ah, 0x02
        mov al, 1
        mov cl, 2
        mov bx, 0x8000
        jmp 0x8000
