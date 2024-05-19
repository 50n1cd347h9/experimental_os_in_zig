.intel_syntax noprefix

.section .data
.section .text
	.global _start

_start:
	// push 0x500 
	// pop esp
	mov esp, _stack
	call kmain
	call trap
