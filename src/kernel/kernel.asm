;=======================================
        ;16RM-OS Kernel made by
        ;xk-rl, ...
        ;Ver. 0.2.2
        ;Last Modified 18 Feb, 2024
        ;Last Modified by, xk-rl
;=======================================
        ;Kernel Information
        ;Sector: 2
        ;Size: < 512 bytes
;=======================================

;---------------------------------------        
;------------------------Kernel-start---
        org 0x8000                      ; Define kernel start
        bits 16                         ; Using 16 bits for now
        
        %define NEXL 0x0D, 0x0A         ; Define \n for .echo label
        jmp .main                       ; Jump to .main label
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
        mov si, loaded
        mov cl, 6
        mov bx, 10000
        call .loaddriver                ; Load first message while also loading driver

        mov si, kb
        mov cl, 6
        mov bx, 10000
        call .loaddriver

        mov si, kb_on
        mov cl, 6
        mov bx, 10000
        call .loaddriver

        mov si, load_tty
        mov cl, 6
        mov bx, 10000
        call .loaddriver

        mov cl, 10
        mov bx, 20000
        call .loaddriver

                                        ; Create example window
        ;mov dx, 20
        ;mov cl, 9
        ;mov bx, 31000
        ;call .loaddriver

        mov si, finished
        mov cl, 6
        mov bx, 10000
        call .loaddriver

        mov ah, 0
        int 16h

        mov cl, 4                       ; Reboot
        mov bx, 9000
        call .loaddriver
;---------------------------------------
;--------------------------------Data---
loaded: 
        db ' SUCCESS   Loaded the kernel and echo driver!', NEXL, 0

kb:
        db '     JOB   Loading keyboard', NEXL, 0

kb_on:  
        db ' SUCCESS   Keyboard loaded!', NEXL, 0

kb_fail:
        db '  FAILED   Could not activate keyboard or skipped by kernel!', NEXL, 0

load_tty:
        db '     JOB   Loading TTY', NEXL, 0

finished:
        db NEXL, '    DONE   Finished the kernel, press any key to continue', 0
;---------------------------------------
;---------------------------CPU-Pause---
.hlt:
        hlt
        jmp .hlt
