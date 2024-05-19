const std = @import("std");

const ALIGN = 1 << 0;
const MEMINFO = 1 << 1;
const MAGIC = 0x1badb002;
const FLAGS = ALIGN | MEMINFO;

const MultiBoot = extern struct {
    magic: i32,
    flags: i32,
    checksum: i32,
};

export var multiboot align(4) linksection(".multiboot") = MultiBoot{
    .magic = MAGIC,
    .flags = FLAGS,
    .checksum = -(MAGIC + FLAGS),
};

// export var stack: [16 * 1024]u8 align(16) linksection(".stack.bss") = undefined;

fn printTest(bytes: []const u8) usize {
    var vga_buffer: *[128]u16 = @ptrFromInt(0xB8000);
    for (bytes, 0..) |byte, i|
        vga_buffer[i] = 0xF0 << 8 | @as(u16, byte);

    return bytes.len;
}

export fn trap() align(4) callconv(.C) noreturn {
    while (true)
        asm volatile ("hlt");
}

export fn kmain() void {
    _ = printTest("Test Test AAAA");
}
