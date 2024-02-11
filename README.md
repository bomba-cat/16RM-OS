# 16RM-OS
16 bit realtime mode operating system made fully in assembly

## Todo list
- ~~Kernel loading other programs~~ Applied
- ~~Kernel either staying in 16bit or going in vt8086 mode~~ staying in 16bit mode because VME isnt stable on AMD
- ~~Better code structure for future purposes and better readability~~
- Minimum requirements
- Basic terminal or tty
- Debugging with bochs
- Remove the disk read from the bootloader and moving it as a driver
- Better file structure
- FAT 12 subdirectory
- ~~If going in 32bit long mode with vt8086 mode add FAT32 file system~~ staying in 16 bit
- Fix loaded driver not returning to kernel

# Drivers/Interrupts todo list
- ~~Driver to return back to the kernel~~
- ~~Driver to reboot~~
- ~~Driver to read keyboard~~
- Driver to print to tty
- Driver to color pixel
- Driver to read/write files
- Driver to load other drivers


# Drivers Memory Location Information
| **Memory Location** | **Driver** | **Exception** |
| --------------- | ------ | --------- |
| 0x7C00 | Bootloader | |
| 0x8000 | Kernel | |
| 9000 | Any drivers which are one time use and can be overwritten later | Read driver |
| 10000 | Echo driver |
| 11000+ | for future purposes |
## Important
I will soon redo the memory reservations to take up less memory and make more available!
Reworking this table soon!

# Drivers Sector Location Information
| **Sector** | **Driver** |
| ------ | ------ |
| 1 | Bootloader |
| 2 | Kernel |
| 3 | Reload Kernel |
| 4 | Reboot |
| 5 | Read Keyboard |
| 6 | Echo |
