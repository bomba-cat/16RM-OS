;=======================================
        ;Screensaver made by
        ;xk-rl, ...
        ;Ver. 0.0.1
        ;Last Modified 15 Feb, 2024
        ;Last Modified by, xk-rl
;=======================================
        ;Screensaver Information
        ;Sector: 11
        ;Size: < 512 bytes
;=======================================

;---------------------------------------
;-------------------Screensaver-Start---
        org 31000
        bits 16

        jmp .main
;---------------------------------------
;--------------------------------Main---

.main:
                                        ; Set video mode to 320x200 color mode
        mov ah, 0h
        mov al, 13h
        int 0x10
        
                                        ; 0=right, 1=left
        mov ax, 0
                                        ; 0=down, 1=up
        mov bx, 0
                                        ; X Position
        mov cx, 0
                                        ; Y Position
        mov dx, 0
                                        ; Color
        mov al, 0

;---------------------------------------
;----------------------------Mainloop---

.mainloop:
        mov ah, 0Ch
        inc al
        int 0x10

.delay:
        push cx
        push dx
        mov ah, 0x86
        xor cx, cx
        mov dx, 0x4240
        int 0x15
        pop dx
        pop cx

.checkx:
        cmp ax, 0
        je .right
        jne .left

.checky:
        cmp bx, 0
        je .down
        jne .up

.right:
        dec cx
        cmp cx, 319
        je .setleft
        jmp .checky

.left:
        inc cx
        cmp cx, 0
        je .setright
        jmp .checky

.down:
        cmp dx, 199
        je .setup
        inc dx
        jmp .mainloop

.up:
        cmp dx, 0
        je .setdown
        dec dx
        jmp .mainloop

.setleft:
        mov ax, 1
        jmp .checky

.setright:
        mov ax, 0
        jmp .checky

.setup:
        mov bx, 1
        jmp .mainloop

.setdown:
        mov bx, 0
        jmp .mainloop

;---------------------------------------
;------------------------------Finish---

.finish:
                                        ; Return back to called program
        ret
