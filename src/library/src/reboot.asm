;=======================================
        ;16RM-OS Reboot Driver made by
        ;xk-rl, ...
        ;Ver. 0.0.1
        ;Last Modified 10 Feb, 2024
        ;Last Modified by, xk-rl
;=======================================
        ;Reboot Driver Information
        ;Sector: 4
        ;Size: < 512 bytes
;=======================================

;---------------------------------------
;-----------------Reboot-Driver-Start---
        org 0x9000
        bits 16
        
        jmp .reboot
;---------------------------------------
;--------------------------------Main---
.reboot:
        jmp 0FFFFh:0
