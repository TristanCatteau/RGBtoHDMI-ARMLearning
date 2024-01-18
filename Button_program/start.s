.section .text
.global _start

.equ GPIO_BASE, 0x20200000
.equ GPFSEL1, 0x04
.equ GPFSEL2, 0x08

.equ GPIO_22_OUTPUT, 0x40;//# 1 << 6
.equ GPIO_17_INPUT, 17

.equ GPFSET0, 0x1c
.equ GPFCLR0, 0x28
.equ GPEDS0, 0x34

.equ MASK_INPUT, 0xFFFFF1FF
.equ MASK_DETECT, 0xFFFDFFFF

.equ GPIOVAL, 0x400000 ;//# 1 << 22
_start:

	;//# base of our GPIO structure
	ldr r0, =GPIO_BASE

	;//# set the GPIO 22 function as output
	ldr r1, =GPIO_22_OUTPUT
	str r1, [r0,#GPFSEL2]
	
	;//# set the GPIO 17 function as input
	ldr r1, =MASK_INPUT
	str r1, [r0,#GPFSEL1]
	
	# set counter
	ldr r2, =0x000001
	
loop:
	# wait for some time, delay
	eor r10, r10, r10
	delay1:
		add r10, r10, #1
		cmp r10, r2
		bne delay1
	bl get_input
	cmp r5, #1
	bne ledoff
	beq ledon
	b loop
	
get_input:
	mov r4, #1
	lsl r4, #17
	ldr r3, [r0, #GPEDS0]; //# on charge l'etat du bouton
	tst r3,r4
	moveq r5, #0
	movne r5, #1
	mov pc, lr
ledon:
	# turn on the LED
	ldr r1, =GPIOVAL ;//# value to write to set register
	str r1, [r0, #GPFSET0] ;//# store in set register
	b loop
ledoff:
	# turn off the LED
	ldr r1, =GPIOVAL ;//# value to write to set register
	str r1, [r0, #GPFCLR0] ;//# store in clr register
	b loop
