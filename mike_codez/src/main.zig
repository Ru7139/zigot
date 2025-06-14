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
    try stdOut.print("\nd1 = {c}, d2 = {}\n", .{ d1, d2 });

    const e = "Here is zig language";
    try stdOut.print("\ne: type = {}\n", .{@TypeOf(e)});
    try stdOut.print("e: length = {}\n", .{e.len});
    try stdOut.print("e: content = {s}\n", .{e});
    try stdOut.print("e: last character = {c}\n", .{e[e.len - 1]});

    const f1 = [_]u32{ 1, 2, 3, 4, 5 };
    try stdOut.print("\nf1: type = {}\n", .{@TypeOf(f1)});
    try stdOut.print("f1: len = {}\n", .{f1.len});
    try stdOut.print("f1: content = {any}\n", .{f1});

    const g1 = [_][]const u8{ "Apple", "Banana", "Cherry" };
    try stdOut.print("g1 = {s}\n", .{g1});

    const final_elapsed_time_ns: i128 = std.time.nanoTimestamp() - start_time; // i128除法需要配置
    std.debug.print("\nExec Done wiht --> {}ns\n", .{final_elapsed_time_ns});
}
