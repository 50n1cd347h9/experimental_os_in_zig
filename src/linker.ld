MEMORY
{
	RAM (rwx): ORIGIN = 0x20000000, LENGTH = 12K /* executable & readable & writable */
    ROM (rx): ORIGIN = 0x08000000, LENGTH = 64K
}


ENTRY(_start)

SECTIONS {
	/* . = 1M; */
	.text : ALIGN(4K) {
		KEEP(*(.multiboot))
		*(.text)
	} > ROM

	 .rodata : ALIGN(4K) {
    	*(.rodata)
    } > ROM

    .data : ALIGN(4K) {
        *(.data)
    } > RAM

    .bss : ALIGN(4K) {
        *(COMMON)
        *(.bss)
		PROVIDE(_bss_end = .);
    } > RAM

	PROVIDE(_stack = _bss_end + 0x80000);
}
