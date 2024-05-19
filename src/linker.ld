MEMORY
{
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 64K 
    ROM (rx) : ORIGIN = 0x00100000, LENGTH = 512K
}

ENTRY(_start)

SECTIONS {
    .text : ALIGN(4) {
        KEEP(*(.multiboot))
        *(.text .text.*)
        *(.text.init)
    } > ROM

    .rodata : ALIGN(4) {
        *(.rodata)
    } > ROM

    .data : ALIGN(4) {
        *(.data)
    } > RAM

    .bss : ALIGN(4) {
        *(COMMON)
        *(.bss)
        PROVIDE(_bss_end = .);
    } > RAM

    PROVIDE(_stack = ORIGIN(RAM) + LENGTH(RAM));
}
