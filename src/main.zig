const ALIGN = 1 << 0;
const MEMINFO = 1 << 1;
const MAGIC = 0x1badb002;
const FLAGS = ALIGN | MEMINFO;

const STACK_SIZE = 0x4000 << 8;

const MultiBoot = extern struct {
    magic: i32,
    flags: i32,
    checksum: i32,
};

export const multiboot align(4) linksection(".multiboot") = MultiBoot{
    .magic = MAGIC,
    .flags = FLAGS,
    .checksum = -(MAGIC + FLAGS),
};

export var stack: [STACK_SIZE]u8 align(16) linksection(".stack.bss") = undefined;
export const _stack_top: *u8 = &stack[stack.len - 1];

comptime {
    asm (
        \\ .intel_syntax noprefix
        \\ .global _start
        \\ _start:
        \\      mov esp, _stack_top 
        \\      call kmain
        \\      hlt
    );
}

export fn kmain() void {
    const vga_buffer: *[128]u16 = @ptrFromInt(0xB8000);
    inline for ("fuck linker script", 0..) |byte, i|
        vga_buffer[i] = 0xF0 << 8 | @as(u16, byte);
}
