const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const BufferedWriter = std.io.BufferedWriter(8 * 1024, @TypeOf(stdout));
    var print_buffer = BufferedWriter{ .unbuffered_writer = stdout };
    var print_writer = print_buffer.writer();

    const start_time: i128 = std.time.nanoTimestamp();

    const c = add(10, 20);
    try asserteq_ln_to_buffer(&print_writer, "c", c);

    try EndProgram_With_ElapsedTime(&print_buffer, &print_writer, start_time);
}

fn add(a: i32, b: i32) i32 {
    return a + b;
}

fn asserteq_ln_to_buffer(writer: anytype, name: []const u8, value: anytype) !void {
    try writer.print("{s} = {}\n", .{ name, value });
}

fn EndProgram_With_ElapsedTime(
    buffer: anytype,
    writer: anytype,
    start_time: i128,
) !void {
    const end_time = @as(i128, std.time.nanoTimestamp());
    const elapsed: i128 = end_time - start_time;
    try writer.print("Exec Done with --> {}ns\n", .{elapsed});
    try buffer.flush();
}
