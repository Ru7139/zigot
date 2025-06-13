const std = @import("std");

pub fn main() !void {
    const stdOut = std.io.getStdOut().writer();

    const start_time = std.time.nanoTimestamp();

    const a: u32 = 10;
    const b: u32 = 20;
    try stdOut.print("a = {}, b = {}\n", .{ a, b });

    const c1: u8 = 65;
    const c2: u8 = 'A';
    std.debug.assert(c1 == c2);

    const d1: u8 = 66;
    const d2: u8 = 'B';
    try stdOut.print("d1 = {c}, d2 = {}\n", .{ d1, d2 });

    const final_elapsed_time_ns: i128 = std.time.nanoTimestamp() - start_time; // i128除法需要配置
    std.debug.print("Exec Done wiht --> {}ns\n", .{final_elapsed_time_ns});
}
