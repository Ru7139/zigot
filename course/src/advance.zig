const std = @import("std");

pub fn main() !void {
    const output = std.io.getStdOut().writer();
    var output_buffer = std.io.bufferedWriter(output);
    var output_writer = output_buffer.writer();

    try output_writer.print("Here is the code of first line\n", .{});

    try output_buffer.flush();
}
