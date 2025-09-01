const std = @import("std");

test "expect this to succeed" {
    try std.testing.expect(true);
}

test "this will be skipped" {
    return error.SkipZigTest;
}
