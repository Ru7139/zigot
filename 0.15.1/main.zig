const std = @import("std");
const test_file = @import("test_zh_doc.zig");

const print = std.debug.print;
const assert = std.debug.assert;

pub fn main() !void {
    const program_start = std.time.nanoTimestamp();
    std.testing.refAllDeclsRecursive(test_file);

    // std.Thread.sleep(1_000_000_000);
    const program_end = std.time.nanoTimestamp();
    const diff_start_end_time = program_end - program_start;
    print("task consumed ---> {}", .{diff_start_end_time});
}
