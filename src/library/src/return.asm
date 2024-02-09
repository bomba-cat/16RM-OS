;=======================================
        ;16RM-OS Return Driver made by
        ;xk-rl, ...
        ;Ver. 0.0.1
        ;Last Modified 09 Feb, 2024
        ;Last Modified by, xk-rl
;=======================================
        ;Return Driver Information
        ;Sector: 3
        ;Size: < 512 bytes
;=======================================

;---------------------------------------
;---------Return-Driver-Start-----------
        org 0x9000
        bits 16
        
        jmp .return
;---------------------------------------
;-----------------Main------------------
.return:
                                        ; Implement message saying "Returning to Kernel"
        jmp 0x8000
