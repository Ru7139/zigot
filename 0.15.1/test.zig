const std = @import("std");

test "test_or_skip_example" {
    std.debug.print("\t---> test <---\n", .{});

    const ts = std.time.timestamp();
    if (@mod(ts, 2) == 0) {
        std.debug.print("{} can be divided by 2\n", .{ts});
        try std.testing.expect(true);
    } else {
        std.debug.print("time stamp is {}\n", .{ts});
        return error.SkipZigTest;
    }
}

test "0.0 ---> hello_world_test" {
    std.debug.print("\nHello, World!\n", .{});
}

test "1.1 ---> variable declare" {
    var k: u32 = 0;
    k += 100;
    const p: u32 = k;
    std.debug.assert(p == 100);
}
