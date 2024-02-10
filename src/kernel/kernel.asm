;=======================================
        ;16RM-OS Kernel made by
        ;xk-rl, ...
        ;Ver. 0.1.7
        ;Last Modified 10 Feb, 2024
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
;------------------------Print-to-TTY---
.echo:
        push si                         ; Push used registers
        push ax
.loopecho:                              ; Print loop for each letter
        lodsb                           ; Load next character in al
        or al, al                       ; Check if al not equal to 0
        jz .finecho                     ; If equal then finish
        mov ah, 0x0E                    ; Teletype output
        mov bh, 0                       ; Page number
        int 0x10                        ; Bios interrupt
    
        jmp .loopecho                   ; Loop
.finecho:
        pop ax                          ; Pop back our registers and return
        pop si
        ret
;---------------------------------------
;--------------------------------Main---
.main:
        mov si, loaded
        call .echo

        mov si, kb
        call .echo

        mov si, kb_on
        call .echo

        mov ah, 0x02                    ; Read the third sector, load it into the RAM and jump there
        mov al, 1
        mov cl, 4
        mov bx, 0x9000
        int 0x13

        jmp 0x9000

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
;---------------------------------------
;---------------------------CPU-Pause---
.hlt:
        cli                            ; Set CPU in an infinite idling state
        hlt
        jmp .hlt
