const std = @import("std");

pub fn main() !void {
    try std.fs.File.stdout().writeAll("Hello");
    std.debug.print(" {s}\n", .{"World!"});
}

const CosmosRocket = struct {
    index: u16,
};
