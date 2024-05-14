const std = @import("std");
const Build = std.Build;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{
        .default_target = .{ .cpu_arch = .x86, .os_tag = .freestanding },
    });

    const os = b.addExecutable(.{
        .name = "os.elf",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
    });
    os.setLinkerScriptPath(.{ .path = "src/linker.ld" });
    b.installArtifact(os);

    const run_cmd = b.addSystemCommand(&.{
        "qemu-system-i386",
        "-kernel",
        "zig-out/bin/os.elf",
        "-display",
        "gtk,zoom-to-fit=on",
    });
    const run_step = b.step("run", "Run the os");

    run_cmd.step.dependOn(&os.step);
    run_step.dependOn(&run_cmd.step);
}
