.intel_syntax noprefix

.section .data

.section .text.init

.global _start
_start:
	mov sp, _stack
	call kmain
