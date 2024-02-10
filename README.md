# 16RM-OS
16 bit realtime mode operating system made fully in assembly

## Todo list
- ~~Kernel loading other programs~~ Applied
- ~~Kernel either staying in 16bit or going in vt8086 mode~~ staying in 16bit mode because VME isnt stable on AMD
- ~~Better code structure for future purposes and better readability~~
- Minimum requirements
- Basic terminal or tty
- Basic drivers for the kernel for reading the keyboard, priting to the screen, reading from the disk etc.
- Debuging with bochs
- Remove the disk read driver from the bootloader and moving it as a briver
- Better file structure
- FAT 12 subdirectory
- If going in 32bit long mode with vt8086 mode add FAT32 file system
- Make driver to load drivers

# Drivers/Interrupts todo list
- ~~Driver to return back to the kernel~~
- ~~Driver to reboot~~
- ~~Driver to read keyboard~~
- Driver to print to tty
- Driver to color pixel
- Driver to read/write files


# Drivers Memory Location Information
0x7C00 - Bootloader
0x8000 - Kernel
0x9000 - Any drivers which can be overwritten without causing any damage
0x10000 - Reserved for print/echo driver, shall not be overwritten at any cost
0x11000+ - Not allocated yet, free to use
## Important
I will soon redo the memory reservations to take up less memory and make more available!
