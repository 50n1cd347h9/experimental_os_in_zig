pub fn puts(bytes: []const u8) void {
    const vga_buffer: *[128]u16 = @ptrFromInt(0xB8000);
    for (bytes, 0..) |byte, i|
        putc(&vga_buffer[i], byte);
}

pub fn putc(buf: *u16, byte: u8) void {
    buf.* = 0xF0 << 8 | @as(u16, byte);
}

// pub fn printf(fmt: []const u8, args: anytype) void {
//     const ArgsType = @TypeOf(args);
//     comptime const num_args = args.len;
//     comptime var i: u32 = 0;
//     comptime var strings_to_print: []u8 = undefined;
//     var arg_index: u32 = 0;
//
//
//     if (@typeInfo(ArgsType) != .Struct) {
//         @compileError("expected tuple or struct argument, found" ++ @typeName(ArgsType));
//     }
//
//     if (num_args == 0) {
//         @compileError("expected tuple or struct that have one field at least");
//     }
//     // var buf: [0x100]u8 = undefined;
//
//     inline while (i < fmt.len) {
//         inline while (i < fmt.len) : (i += 1) {
//             switch (fmt[i]) {
//                 '\\' => {
//                     i += 1;
//                     break;
//                 },
//                 else => {},
//             }
//         }
//
//         if (fmt[i] != 'x') {
//             @compileError("expect x next to \\");
//         }
//
//         if (fmt[i] == 'x'){
//             arg_index += 1;
//             const arg = args[arg_index];
//             puts()
//         }
//
//     }
//
//     // // TODO: concatenate fmt and integer
//     _ = fmt;
//     return args;
// }
