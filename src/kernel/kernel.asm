;=======================================
        ;16RM-OS Kernel made by
        ;xk-rl, ...
        ;Ver. 0.2.2
        ;Last Modified 16 Feb, 2024
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

                                        ; Keyboard test
        ;mov si, kb_test_space
        ;mov cl, 6
        ;mov bx, 10000
        ;call .loaddriver

        ;mov cl, 5
        ;mov bx, 9000
        ;call .loaddriver

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

kb_test:     
        db '     JOB   Enabling keyboard, type something and hit enter', NEXL, 0

kb:
        db '     JOB   Enabling keyboard', NEXL, 0

kb_on:  
        db ' SUCCESS   Keyboard enabled!', NEXL, 0

kb_fail:
        db '  FAILED   Could not activate keyboard or skipped by kernel!', NEXL, 0

kb_test_space:
        db '           ', 0

load_tty:
        db '     JOB   Loading TTY', NEXL, 0

finished:
        db NEXL, '    DONE   Finished the kernel, press any key to continue', 0
;---------------------------------------
;---------------------------CPU-Pause---
.hlt:
        hlt
        jmp .hlt
