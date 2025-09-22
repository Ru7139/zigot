const std = @import("std");
const expect = std.testing.expect;
const assert = std.debug.assert;
const print = std.debug.print;

test "2.1 type convert" {
    // 当无法安全得从一个类型转换到另一个类型时
    // 比如 i32 -> u32 -> u8
    // 编译器会自动完成转换

    // (comptime_float / comptime_int)
    // is illegal

    var f: f32 = undefined;

    f = 32 / 5;
    assert(f == 6);

    f = 32.0 / 5.0;
    assert(f == 6.4);
}

test "2.2 memory management" {}

test "2.3 comptime" {}

test "2.4 reflection" {}

test "2.5 asynchronous" {}

test "2.6 assmbly" {}

test "2.7 atomic operation" {}

test "2.8 ffi interactive with c language" {}

test "2.9 undefined operation" {}
