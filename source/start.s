.align 4
.global _entry

.section .text.start, "x"

_entry:
	ldr r0, =0x04000200
	mov r1, #0
	str r1, [r0, #8]	//disable ime
	str r1, [r0, #0x10]	//disable all interrupts
	str r1, [r0, #0x18]
	mov r1, #0xFFFFFFFF
	str r1, [r0, #0x14]	//clear pending irqs
	str r1, [r0, #0x1C]
	bl bss_loop
	ldr sp, =0x03800000	//setup stack
	ldr r0, =0x02FFFE24 //wait address for sync
	ldr r1, =0xdeadbeef	//dummy value so we know the state
	str r1, [r0]	//set wait address to dummy value
	bl main	//start executing C code
	ldr r0, =0x06000000 //arm9 should have mapped our payload here
	bx r0	//jump to payload

bss_loop:
	ldr	r0, =__bss_start
	ldr	r1, =__bss_end
	mov	r2, #0
clear_bss:
	cmp	r0, r1 //check if we're at the end
	bxeq lr //if we're at the end, return
	str	r2, [r0], #4 //clear the word
	b clear_bss

.pool

.align 4

.global arm9_code
arm9_code:
	mov r0, #0x04000000
	mov r1, #0
	str r1, [r0, #0x208]	//disable ime
	str r1, [r0, #0x210]	//disable all interrupts
	mov r1, #0xFFFFFFFF
	str r1, [r0, #0x214]	//clear pending irqs
	ldrb r1, =0x82
	strb r1, [r0, #0x242]	//enable VRAM and map it to arm7
	bl flush_instruction_cache
	ldr r0, =0x02FFFE24
	mov r1, #0
	str r1, [r0] //signal to arm7 that we've got control
wait_for_arm7:
	ldr r1, [r0]
	cmp r1, #0	//check that the wait address isn't NULL
	beq wait_for_arm7
	bx r1 //if the wait address isn't NULL, jump to it

.pool

flush_instruction_cache:
	mov r0, #0
	mcr p15, 0, r0, c7, c5, 0
	bx lr

.global arm9_code_end
arm9_code_end:

.global bootloader
bootloader:
	.incbin "../build/load.bin"
.global bootloader_end
bootloader_end:
