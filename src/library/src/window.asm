;=======================================
        ;16RM-OS Window driver made by
        ;xk-rl, ...
        ;Ver. 0.0.1 Experimental
        ;Last Modified 18 Feb, 2024
        ;Last Modified by, xk-rl
;=======================================
        ;Window driver Information
        ;Sector: 9
        ;Size: < 512 bytes
        ;cx: height
        ;dx: width
;=======================================

;---------------------------------------
;------------------------Window-Start---
        org 31000
        bits 16

        %define NEXL 0x0D, 0x0A
        pop cx
        pop dx
        jmp .setup
;---------------------------------------
;------------------------------Draw-----

.draw:
        call .push
        mov ah, 0x02
        mov al, 1
        mov cx, 6
        mov bx, 10000
        int 0x13

        call .pop

        jmp 10000

;---------------------------------------
;------------------Preserve-Registers---

.push:
        push ax
        push bx
        push cx
        push dx
        ret
.pop:
        pop dx
        pop cx
        pop bx
        pop ax
        ret

;---------------------------------------
;-----------------------Create-Window---

.setup:
        mov ax, cx
        mov bx, dx

.create:
        call .top
        ret

;---------------------------------------
;-----------Different-Window-Segments---

.top:
        mov si, tl
        call .draw
        dec dx

        mov si, t
        call .draw
        dec dx
        cmp dx, 1
        je .finishtop
        jmp .top

.finishtop:
        mov si, tr
        call .draw
        mov dx, bx
        ret

;---------------------------------------
;--------------------------------Data---

tl: 
        db 0xC9, 0

t: 
        db 0xCD, 0

tr: 
        db 0xBB, NEXL, 0

ble:
        db 0xC8, 0

br: 
        db 0xBC, 0

wall: 
        db 0xBA, 0

empty: 
        db 0xFF, 0
