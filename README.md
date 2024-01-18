# RGBtoHDMI-ARMLearning
### Introduction
This project is based on the original RGBtoHDMI project by hoglet67 
https://github.com/hoglet67/RGBtoHDMI/wiki
In our case study, we are looking to simplify the project and run it on a TRS-80.
In this context, which you'll find in more detail in the report, I'm interested in learning the ARM assembly language.
We want to flash an LED and then turn on an LED using a button.

### Equipment used :
- RapsberryPi model B with associated usb cable and SD card
- Cables, a button, an LED and a suitable resistor
- A Linux computer with an IDE of your choice

I'll also need to download several packages, in particular a compiler for the ARM language (gcc-arm-none-eabi), which will be able to build my code in binary. 
I also installed the 'make' package (on the command line: $sudo apt install make) which allows you to build different files, in our case kermel, which will also be read by the Raspberry Pi. 
It will transform our assembly language files into binaries, stored in the kernel.
All the code will be put on an SD card, formatted in FAT32 format, to avoid reading problems by the Raspberry Pi.

### Bare metal system
To use the Raspberry Pi in bare metal, you first need to boot it, i.e. start it up with the lowest possible program. 
The Raspberry Pi has a particular way of reading data: When you plug in the power supply, only the GPU is active. 
It is the GPU that will start the whole system with the corresponding files. 
To do this, we'll need several files to put on the SD card: 
- bcm278-rpi-b.dtb (Used to define which systems we are using, in this case model B)
- bootcode.bin (the first file read by ROM40, activates the SDRAM and loads the start.elf, which enables the system to boot)
- start.elf (this is the GPU firmware, which powers up the CPU and loads the other files)
- fixup.dat (Allows you to allocate 1GB of memory)
- kermel.img (the bare metal application to read)

Once these files have been placed on the SD card, which can be retrieved from the Internet, 
we insert it into the Raspberry, connect an HDMI cable to check that it is working properly and finally connect the power supply. 
The PWR LED (power, which indicates that it is receiving power) is lit, and the ACT LED (action) will flash, so it will initialise. 
You'll have to wait about ten seconds for it to stay lit, which means it's ready for configuration, and the core may be ready to be installed. 
In our case, we don't want to install an OS, as we want to stay at the lowest level. 
We can now disconnect the power supply, then the HDMI and finally the board. Our Raspberry Pi is now ready to run assembly programs.
