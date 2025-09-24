const std = @import("std");
const expect = std.testing.expect;
const assert = std.debug.assert;
const print = std.debug.print;
const mem_euqal = std.mem.eql;

fn assert_u8str_eql(str_x: []const u8, str_y: []const u8) void {
    assert(mem_euqal(u8, str_x, str_y));
}

fn display_it_print_ln(x: anytype) void {
    print("{}\n", .{x});
}

test "2.1 type convert" {
    // 当无法安全得从一个类型转换到另一个类型时
    // 比如 i32 -> u32 -> u8
    // 编译器会自动完成转换

    // (comptime_float / comptime_int)
    // is illegal

    var f: f32 = undefined;
    f = 32 / 5; // 6
    assert(std.math.approxEqAbs(f32, (32.0 / 5.0), f + 0.4, 1e-10));

    // 两者在 [5]u8 情况下几乎没区别
    // 差别主要在 是否考虑结尾 0 和 写法上的显式/隐式
    var buf_0: [5]u8 = "hello".*; // 没有0作为结尾
    const ptr_0: [*]u8 = &buf_0;
    ptr_0[0] = 'X';
    assert_u8str_eql("Xello", &buf_0);

    var buf_1: [3]u8 = "yes".*;
    const ptr_1: ?[*]u8 = &buf_1; // Option<T>
    ptr_1.?[0] = 'K';
    assert_u8str_eql("Kes", &buf_1);

    var buf_2: [4]u8 = "ACBD".*;
    const ptr_2: anyerror!?[*]u8 = &buf_2; // Result<Option<T>, E>
    (try ptr_2).?[3] = 'Z';
    assert_u8str_eql("ACBZ", &buf_2);

    // 联合枚举 union(enum) 可自行推断

    var buf_3: i32 = 1234;
    const ptr_3: *[1]i32 = &buf_3; // 先转化为array
    const ptr_3_b: [*]i32 = ptr_3; // 转化到array ptr
    ptr_3_b[0] = 5;
    assert(buf_3 == 5);

    const buf_4_a: i32 = -125;
    const buf_4_b: u32 = @bitCast(buf_4_a);
    assert(buf_4_b == 4294967171);

    const buf_5_a: [4]u8 = .{ 0b0000_0001, 0b0000_0010, 0b0000_0011, 0b0000_0100 };
    var buf_5_b: u32 = undefined;
    const ptr_5_a: *const [4]u8 = &buf_5_a;
    const ptr_5_b: *u32 = @ptrCast(@alignCast(@constCast(ptr_5_a)));
    buf_5_b = ptr_5_b.*;
    assert(buf_5_b == 67305985);
    assert(buf_5_b == 0b0000_0100_0000_0011_0000_0010_0000_0001);
}

test "2.2 memory management" {}

test "2.3 comptime" {}

test "2.4 reflection" {}

test "2.5 asynchronous" {}

test "2.6 assmbly" {}

test "2.7 atomic operation" {}

test "2.8 ffi interactive with c language" {}

test "2.9 undefined operation" {}
