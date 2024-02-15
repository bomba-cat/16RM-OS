;=======================================
        ;Assembly Terminal made by
        ;xk-rl, ...
        ;Ver. 0.1.1
        ;Last Modified 14 Feb, 2024
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
;---------------------Compare-Strings---

.compare:
        push si
.compareloop:
        lodsb
        scasb
        jne .notequal
        test al, al
        jnz .compareloop
        pop si
        ret

.notequal:
        pop si
        ret

;---------------------------------------
;--------------------------------Main---

.main:                                  ; Prompt
        mov si, tty
        mov cl, 6
        mov bx, 10000
        call .loaddriver

                                        ; Read driver, returns at SI
        mov cl, 5
        mov bx, 9000
        call .loaddriver

;---------------------------------------
;----------------------------Commands---

                                        ; Clear, setting video mode
        mov di, clear
        call .compare
        je .clear

                                        ; Reboot, call reboot driver
        mov di, reboot
        call .compare
        je .reboot

                                        ; Reload, call reload kernel driver
        mov di, reload
        call .compare
        je .reload

                                        ; Resolution, switch resolution to 320x200
                                        ; Switch back using clear command
        mov di, res1
        call .compare
        je .res1

                                        ; If nothing, echo given command
        mov cl, 6
        mov bx, 10000
        call .loaddriver

        jmp .main

        ret

;---------------------------------------
;--------------------Command-Handlers---

.clear:
        mov ah, 0h
        mov al, 3h
        int 0x10
        jmp .main

.reboot:
        mov cl, 4
        mov bx, 9000
        call .loaddriver

.reload:
        mov cl, 3
        mov bx, 9000
        call .loaddriver

.res1:
        mov ah, 0h
        mov al, 1h
        int 0x10
        jmp .main

;---------------------------------------
;--------------------------------Data---

tty:
        db NEXL, '16RM-TTY-> ', 0

reboot:
        db 'reboot', 0

clear:
        db 'clear', 0

reload:
        db 'reload', 0

res1:
        db 'res1', 0
