;=======================================
        ;16RM-OS Kernel made by
        ;xk-rl, ...
        ;Ver. 0.1.7
        ;Last Modified 11 Feb, 2024
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
        call .loaddriver

        mov si, kb
        mov cl, 6
        mov bx, 10000
        call .loaddriver

        mov si, kb_test_space
        mov cl, 6
        mov bx, 10000
        call .loaddriver

        mov cl, 5
        mov bx, 9000
        call .loaddriver

        mov si, kb_on
        mov cl, 6
        mov bx, 10000
        call .loaddriver

        mov cl, 4
        mov bx, 9000
        call .loaddriver
;---------------------------------------
;--------------------------------Data---
loaded: 
        db ' SUCCESS   Loaded the Kernel!', NEXL, 0

kb:     
        db '     JOB   Enabling keyboard, type something and hit enter', NEXL, 0

kb_on:  
        db ' SUCCESS   Keyboard enabled!', NEXL, 0

kb_fail:
        db '  FAILED   Could not activate Keyboard or skipped by Kernel!', NEXL, 0
kb_test_space:
        db '           ', 0
;---------------------------------------
;---------------------------CPU-Pause---
.hlt:
        cli                             ; Set CPU in an infinite idling state
        hlt
        jmp .hlt
