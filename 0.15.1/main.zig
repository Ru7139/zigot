const std = @import("std");

pub fn main() !void {
    try std.fs.File.stdout().writeAll("Hello");
    std.debug.print(" {s}\n", .{"World!"});

    const int_32_value_example: i32 = 23 + 37;
    const float_32_value_example: f32 = @as(f32, int_32_value_example) / 11.0;
    std.debug.print("i32: {}, f32: {}", .{ int_32_value_example, float_32_value_example });
}

const CosmosRocket = struct {
    index: u16,
};
