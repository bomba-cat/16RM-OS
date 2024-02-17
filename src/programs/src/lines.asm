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
        mov si, 0
                                        ; 0=down, 1=up
        mov bx, 0
                                        ; X Position
        mov cx, 0
                                        ; Y Position
        mov dx, 0
                                        ; Color
        mov al, 4

;---------------------------------------
;----------------------------Mainloop---

.resetal:
        mov al, 4

.mainloop:
        mov ah, 0Ch
                                        ; Changing color
        ;dec al
        
        cmp al, 0
        je .resetal

        int 0x10
                                        ; Uncomment for no delay
        ;jmp .checkx

.delay:
        push cx
        push dx
        mov ah, 0x86
        xor cx, cx
        mov dx, 0x4248
        int 0x15
        pop dx
        pop cx

.checkx:
        cmp si, 0
        je .right
        jne .left

.checky:
        cmp bx, 0
        je .down
        jne .up

.right:
        cmp cx, 319
        je .setleft
        inc cx
        jmp .checky

.left:
        cmp cx, 0
        je .setright
        dec cx
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
        mov si, 1
        dec cx
        inc al
        jmp .checky

.setright:
        mov si, 0
        inc cx
        inc al
        jmp .checky

.setup:
        mov bx, 1
        dec dx
        inc al
        jmp .mainloop

.setdown:
        mov bx, 0
        inc dx
        inc al
        jmp .mainloop

;---------------------------------------
;------------------------------Finish---

.finish:
                                        ; Return back to called program
        ret
