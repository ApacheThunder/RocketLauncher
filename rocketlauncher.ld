OUTPUT_ARCH(arm)
ENTRY(_entry)
SECTIONS
{
	. = 0x380D000;
	.text : {
		*(.text.start)
		*(.text)
	}
	.data : {
		*(.data)
	}
	.bss : {
		__bss_start = .;
		*(.bss COMMON)
	}
	__bss_end = .;
	.rodata : {
		*(.rodata)
	} = 0x00000000

	.read_only : {
		FILL(0xFFFFFFFF)
	}

	. = 0x0380FFFC;
	.const : {
		LONG(0x380D000)
	}
	__end__ = .;
}
