const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;

fn println_fn(name: []const u8, x: anytype) void {
    print("{s}: {} ---> {}\n", .{ name, @TypeOf(x), x });
}

test "test_or_skip_example" {
    print("\t---> test <---\n", .{});

    const ts: i64 = std.time.timestamp();
    if (@mod(ts, 2) == 0) {
        print("{} can be divided by 2\n", .{ts});
        try std.testing.expect(true);
    } else {
        print("time stamp is {}\n", .{ts});
        return error.SkipZigTest;
    }
}

test "0.0 ---> hello_world_test" {
    print("\n\t---> Hello, World! <---\n", .{});
}

test "1.1 ---> variable declare" {
    var k: u32 = 0;
    k += 100;
    const p: u32 = k;
    assert(p == 100);

    const t: u32 = undefined;
    println_fn("t(undefined)", t);

    var x: u32 = undefined;
    var y: u32 = undefined;
    var z: u32 = undefined;
    const tuple_1 = .{ 1, 2, 3 };
    x, y, z = tuple_1;
    println_fn("tuple ---> x+y+z", x + y + z);

    const array_1 = [_]u32{ 7, 8, 9 };
    x, y, z = array_1;
    println_fn("array ---> x+y+z", x + y + z);

    const vec_1: @Vector(3, u8) = .{ 1, 0, 1 };
    x, y, z = vec_1;
    println_fn("vector ---> x+y+z", x + y + z);

    {
        var q: i32 = 1;
        q += 1;
    } // q has been dropped

    {
        var u: u32 = 100;
        const add_u = block_0: { // closure
            u += 100;
            break :block_0;
        };
        add_u;
        println_fn("u", u);
        println_fn("closure ---> add_u", add_u);
    }

    // --- forbidden --- (shadow)
    // use block to declare a same identity name as name
    //

}

test "1.2 @(1/3) ---> basic types (numbers value)" {
    const one_billion = 1_000_000_000;
    const binary_mask = 0b1_1111_1111;
    const permisssions = 0o7_5_5;
    const big_address = 0xFF80_FFFF_FFFF_FFFF;
    const tuple_1 = .{ one_billion, binary_mask, permisssions, big_address };
    println_fn("tuple_1", tuple_1);

    const int_7: i7 = std.math.maxInt(i7);
    const uint_7: u7 = std.math.maxInt(u7);
    const sum_i7_u7: u32 = @as(u32, @intCast(int_7)) + @as(u32, uint_7);
    println_fn("maxInt.i7 + maxInt.u7", sum_i7_u7);

    // 10x ---> 123456789
    // 16x ---> 0xffff
    // 8x ---> 0o755
    // 2x(binnary) ---> 0b_1111_0000

    const value_0: u32 = (3 + 2 - 1) * 3; // 12
    const x: f64 = @divTrunc(@as(i32, value_0) * (-1), 5);
    println_fn("x", x); // -12/5 ---> -2.4 ---> -2
    const y: f64 = @divFloor(@as(i32, value_0) * (-1), 5);
    println_fn("y", y); // -12/5 ---> -2.4 ---> -3
    const z: f64 = @divExact(value_0, 4);
    println_fn("z", z);

    const u32_max: u32 = std.math.maxInt(u32);
    assert(u32_max == 4294967295);
    const add_overflow = @addWithOverflow(u32_max, 128); // show what the bit are
    println_fn("add_overflow", add_overflow);

    const i32_min: i32 = std.math.minInt(i32);
    assert(i32_min == -2147483648);
    const min_overflow = @subWithOverflow(i32_min, 1); // 2147483647
    println_fn("min_overflow", min_overflow);

    const mul_val_0: u32 = @divTrunc(std.math.maxInt(u32), 3) + 1;
    const mul_overflow = @mulWithOverflow(mul_val_0, 3);
    assert(mul_overflow[0] == 2);
    println_fn("mul_overflow", mul_overflow);

    const u64_0: u64 = 1; // 0001
    const shift_amt_0: u4 = 2;
    const shl_overflow = @shlWithOverflow(u64_0, shift_amt_0);
    assert(shl_overflow[0] == 0b100);
    println_fn("shift_amt_0", shl_overflow);

    var zero_val: u32 = std.math.maxInt(u32);
    zero_val +%= 3;
    assert(zero_val == 2);
    zero_val -%= 3;
    assert(zero_val == std.math.maxInt(u32));
    zero_val *%= 10;
    zero_val -%= (std.math.maxInt(u32) - 10);
    assert(zero_val == 1);
    println_fn("zero_val", zero_val);

    const inf_0: f64 = std.math.inf(f64);
    println_fn("inf_0", inf_0);
    const negative_inf_0: f32 = -std.math.inf(f32);
    println_fn("negative_inf_0", negative_inf_0);
    const nan_0: f128 = std.math.nan(f128);
    println_fn("nan_0", nan_0);

    assert(0.1 + 0.2 != 0.3);

    // common algorithm
    // == !=
    // > >=
    // < <=
    // + - * /
    // << >>
    // and or !
    // a&b, a|b, a^b, a~b
    // 饱和运算，不会超过最大值
    // +|, -|, *|, <<|
    // 数组串联 ++
    // 数组重复 **

    const Complex: type = std.math.Complex(f64);
    const complex_i = Complex.init(0, 1); // Z = 0 + 1i;

    const z_1 = complex_i.mul(complex_i); // Z^2 = -1 + 0i
    println_fn("z_1", z_1);

    const z_2 = std.math.complex.pow(complex_i, Complex.init(2, 0));
    println_fn("z_2", z_2);

    const z_3 = std.math.complex.exp(complex_i.mul(Complex.init(std.math.pi, 0)));
    println_fn("z_3", z_3);

    const z_4 = Complex.init(1, 2).mul(Complex.init(1, -2));
    println_fn("z_4", z_4);

    return error.SkipZigTest;
}

test "1.2 @(2/3) ---> basic types (string value)" {
    const me_zh: comptime_int = '我';
    println_fn("me_zh", me_zh);
    const me_eng: comptime_int = 'I';
    println_fn("me_eng", me_eng);

    const string_0: []const u8 = "Here is the zig program language";
    print("{any}\n", .{string_0});
    print("{s}\n", .{string_0});

    const string_1: []const u8 =
        \\H
        \\I
    ;
    assert(string_1[0] == 'H');
    assert(string_1[1] == '\n');
    assert(string_1[2] == 'I');
    assert(string_1.len == 3);

    // c_char
    // bool value: true false only takes 1 bytes

}

test "1.2 @(3/3) ---> basic types (function)" {
    const add_fn = struct {
        inline fn com_add_or_min_2b(comptime T: type, a: T, b: T) T {
            const bm2 = 2 *| b;
            return if (a > b) @subWithOverflow(a, bm2)[0] else (a +| bm2);
        }
    };
    const val = add_fn.com_add_or_min_2b(u16, 150, 10);
    println_fn("val", val);

    const closure_func = struct {
        inline fn football(comptime x: i32) fn (i32) i32 {
            return struct {
                fn ball_counts(y: i32) i32 {
                    var counts = 0;
                    for (x..y) |i| {}
                }
            };
        }
    };
}
