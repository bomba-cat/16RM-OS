org 0x7C00                              ; Starting Position of Bootloader
bits 16                                 ; Using 16 bit Real mode

%define NEXL 0x0D, 0x0A

jmp short start                         ; Jump to the main instruction
nop

bdb_oem: db 'MSWIN4.1'	                ; 8 bytes
bdb_bytes_per_sector: dw 512
bdb_sectors_per_cluster: db 1
bdb_reserved_sectors: dw 1
bdb_fat_count: db 2
bdb_dir_entry_count: dw 0E0h
bdb_total_sectors: dw 2880	            ; 2880 * 512 = 1.44Mb
bdb_media_descriptor_type: db 0F0h		; F0 = 3.5" Floppy disk
bdb_sectors_per_fat: dw 9		        ; 9 Sectors Fat
bdb_sectors_per_track: dw 18
bdb_head: dw 2
bdb_hidden_sectors: dd 0
bdb_large_sector_count: dd 0

;
; Extended Boot Record
;
ebr_drive_number: db 0		            ; 0x00 = floppy, 0x80 = hdd, useless actually
				  db 0	    	        ; reserved
ebr_signature: db 29h
ebr_volume_id: db 12h, 34h, 56h 78h     ; Volume ID, not needed, can be anything
ebr_volume_label: db '16RM-OS    '      ; 11 bytes, padded with spaces!!!
ebr_system_id: db 'FAT12   '	        ; 8 bytes, padded with spaces!!!

start:
    jmp .main

.echo:
    push si                             ; Push needed registers to stack
    push ax
.loop:
    lodsb                               ; Load next character in al
    or al, al                           ; Check if al is not empty
    jz .finishecho                      ; Jump to label .finishecho

    mov ah, 0x0E                        ; Bios interrupt to print to the TTY
    mov bh, 0
    int 0x10

    jmp .loop
.finishecho:
    pop ax                              ; Pop out stack to the registers
    pop si
    ret

.main:
    mov ax, 0                           ; Setup data segment
    mov dx, ax
    mov es, ax

    ; Setup stack
    mov ss, ax
    mov sp, 0x7C00                      ; Placing stack position in front of the system
                                        ; to prevent the system getting overwritten
    
    mov si, floppy_reading
    call .echo

    mov [ebr_drive_number], dl
    mov ax, 1
    mov cl, 1
    mov bx, 0x7E00
    call .diskread

    mov si, floppy_success
    call .echo

    mov si, kernel_loading
    call .echo

    ; Load kernel

    xor ax, ax                          ; Make it zero
    mov ds, ax                          ; DS must be zero in real mode
    mov es, ax
    mov bx, 0x8000

    mov ah, 0x02                        ; BIOS read sector function
    mov al, 1                           ; Read one sector
    mov ch, 0                           ; Cylinder number
    mov cl, 2                           ; Sector number
    mov dh, 0                           ; Head number
    mov dl, 0
    int 0x13                            ; Call BIOS

    jmp 0x8000:0x0000                   ; Jump to the loaded sector

;Error Handlers!

.floppy_error:
    mov si, floppy_error
    call .echo
    call .wait_and_reboot
.wait_and_reboot:
    mov si, wait_for_keypress_message
    call .echo
    mov ah, 0
    int 16h
    jmp 0FFFFh:0

.lba_to_chs:
    push ax
    push dx

    xor dx, dx
    div word [bdb_sectors_per_track]
    inc dx
    mov cx, dx
    xor dx, dx
    div word [bdb_head]
    mov dh, dl
    mov ch, al
    shl ah, 6
    or cl, ah

    pop ax
    mov dl, al
    pop ax
    ret

.diskread:
    push ax
    push bx
    push cx
    push dx
    push di

    push cx
    call .lba_to_chs
    pop ax
    mov ah, 02h
    mov di, 3

.retry:
    pusha
    stc
    int 13h
    jnc .finishdiskread

    popa
    call .disk_reset

    dec di
    test di, di
    jnz .retry
.fail:
    jmp .floppy_error

.finishdiskread:
    popa

    pop di
    pop dx
    pop cx
    pop bx
    pop ax

    ret
    
.disk_reset:
    pusha
    mov ah, 0
    stc
    int 13h
    jc .floppy_error
    popa
    ret

ret:                                        db ' ', NEXL, 0
wait_for_keypress_message:                  db 'Press any key to reboot', 0
floppy_reading:                             db 'Trying to read from floppy disk...', NEXL, 0
floppy_error:                               db 'Failed to read from floppy disk!', NEXL, 0
floppy_success:                             db 'Successfully read from floppy disk!', NEXL, 0
kernel_loading:                             db 'Trying to load Kernel...', NEXL, 0

times 510-($-$$) db 0                   ; Bios signature
dw 0AA55h
