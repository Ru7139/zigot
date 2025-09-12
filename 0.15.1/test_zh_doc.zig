const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;

fn println_fn(name: []const u8, x: anytype) void {
    print("{s}: {} ---> {}\n", .{ name, @TypeOf(x), x });
}

test "test_or_skip_example" {
    print("\t---> test <---\n", .{});

    // const ts: i64 = std.time.timestamp();
    // if (@mod(ts, 2) == 0) {
    //     print("{} can be divided by 2\n", .{ts});
    //     try std.testing.expect(true);
    // } else {
    //     print("time stamp is {}\n", .{ts});
    //     return error.SkipZigTest;
    // }

    try std.testing.expect(true);
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
        inline fn football(comptime x: usize) fn (usize) usize {
            return struct {
                fn ball_counts(y: usize) usize {
                    var counts: usize = 0;
                    for (x..y) |i| {
                        counts +|= @as(usize, @intCast(i));
                    }
                    print("counts = {}\n", .{counts});
                    return counts;
                }
            }.ball_counts;
            // return add_closure.ball_counts;
        }

        inline fn baseball(x: anytype) @TypeOf(x) {
            return x + 11;
        }

        // export 关键字确保函数在生成的目标文件 (object file) 中可见，并遵循 C ABI
        export fn sub_i8_mul_2_fn(a: i8, b: i8) i8 {
            return (a -| b) *| 2;
        }

        //  extern 说明符用于声明一个将在链接时解析的函数
        // （即该函数并非由 Zig 定义，而是由外部库定义，通常遵循 C ABI，但 C ABI 本身有多种规范）
        //  链接可以是静态链接或动态链接。extern 关键字后面引号中的标识符指定了包含该函数的库
        // （例如 c -> libc.so）。callconv 说明符用于更改函数的调用约定
        extern "c" fn atan2(a: f64, b: f64) f64;
    };

    const clo_0 = closure_func.football(15); // [hoc] 15 is the cature value
    const val_2 = clo_0(25);
    _ = val_2;

    const val_3 = closure_func.baseball(49);
    println_fn("val_3", val_3);

    // noreturn is also a type
    // break continue return unreachable while(true) {}

    const val_4 = closure_func.sub_i8_mul_2_fn(5, 10);
    println_fn("val_4", val_4);

    const val_5 = closure_func.atan2(0.33, 0.55);
    println_fn("val_5", val_5);

    // @branchHint(.cold);
    // 告诉优化器当前函数很少被调用（或不被调用）。该函数仅在_函数作用域_内有效。
    //
    // callconv 关键字用于指定函数的调用约定，这在对外暴露函数或编写裸汇编时非常有用。
    // 请参考 std.builtin.CallingConvention (https://ziglang.org/documentation/master/std/#std.builtin.CallingConvention)
    //
}

test "1.3 (1/8) advance type: array" {
    print("\n----- ----- >>> advance type <<< ----- -----\n", .{});
    const message_0: [5]u8 = [5]u8{ 'T', 'o', 'd', 'a', 'y' };
    assert(message_0[0] == 'T');
    print("mes_0 ---> {s}\n", .{message_0});
    const p1, const p2, const p3, const p4, const p5 = message_0;
    print("{c} {c} {c} {c} {c}\n", .{ p1, p2, p3, p4, p5 });
    // const message_1: []const u8 = "Today is a beautiful day\n";
    // _ = message_1;

    const matrix_33 = [3][3]u32{
        [3]u32{ 1, 2, 3 },
        [3]u32{ 4, 5, 6 },
        [3]u32{ 7, 8, 9 },
    };
    for (matrix_33, 0..) |arr, loc_x| {
        for (arr, 0..) |value, loc_y| {
            print("arr[{}][{}] ---> {}\t", .{ loc_x, loc_y, value });
        }
        print("\n", .{});
    }

    // 哨兵数组（标记终止值的数组）
    const array_with_sign: [5:7]u8 = [_:7]u8{ 1, 2, 4, 8, 16 };
    println_fn("arr_len", array_with_sign.len);

    // 数组重复赋值
    const array_5_times_copy: [30:7]u8 = array_with_sign ** 6; // must be [30:7] or
    // note: array sentinel '7' cannot cast into array sentinel '17'

    print("arr_5_copy ---> {any}\n", .{array_5_times_copy});
    println_fn("[arr_with_sign's last] ---> ", array_with_sign[5]);
    println_fn("[arr_5_copy's last] ---> ", array_5_times_copy[30]);

    const array_part_1: [5]isize = [_]isize{ 2, 4, 6, 8, 10 };
    const array_part_2: [5]isize = [_]isize{ 3, 5, 7, 9, 11 };
    const array_whole: [10]isize = array_part_1 ++ array_part_2;
    print("array_whole ---> {any}\n", .{array_whole});

    const fancy_array = init: {
        var initial_value: [10]usize = undefined;
        for (&initial_value, 0..) |*ptr, index| {
            ptr.* = 2 * index + 1;
        }
        break :init initial_value;
    };
    print("fancy_array ---> {any}\n", .{fancy_array});
}

test "1.3 (2/8) advance type: vector" {
    const vec_1 = @Vector(4, u32){ 1, 2, 3, 4 };
    const arr_1: [4:127]u32 = vec_1;
    print("arr_1 ---> {any}\n", .{arr_1});

    const arr_2 = arr_1 ** 2;
    const vec_2: @Vector(8, u32) = arr_2;
    print("vec_2 ---> {any}\n", .{vec_2});

    const vec_3 = arr_2[2..6].*;
    print("vec_3 ---> {any}\n", .{vec_3});

    const vec_4: @Vector(8, u32) = @splat(10);
    print("vec_4 ---> {any}\n", .{vec_4});

    const V432 = @Vector(4, i32); // 定义了一个 type
    const vec_x1 = V432{ 1, 1, -1, -1 };
    const vec_x2: @Vector(4, i32) = vec_x1 +| @as(V432, @splat(5));
    // 6, 6, 4, 4 ---> 36 * 16 ---> 576
    const rxt = @reduce(.Mul, vec_x2);
    // reduce支持
    // .And .Or .Xor
    // .Max .Min .Add .Mul
    println_fn("rxt ---> {}\n", .{rxt});

    const vec_y1 = @Vector(9, u8){ 'h', 'O', 'W', 'A', 'r', 'e', 'y', 'o', 'u' };
    const vec_y2 = @Vector(4, u8){ 'n', 'I', 'c', 'e' };
    const mask_0 = @Vector(4, i32){ -2, 1, 2, 3 };
    const str_0: @Vector(4, u8) = @shuffle(u8, vec_y1, vec_y2, mask_0);
    print("str_0 ---> {any}\n", .{str_0}); // IOWA

    const vec_z1 = @Vector(4, u8){ 'N', 'O', 'o', 'A' };
    const vec_z2 = @Vector(4, u8){ 'k', 'e', 'V', 'c' };
    const pred_0 = @Vector(4, bool){ true, true, false, true };
    const str_1 = @select(u8, pred_0, vec_z1, vec_z2);
    print("str_1 ---> {any}\n", .{str_1}); // NOVA
}

test "1.3 (3/8) advance type: pointer" {
    var val_i8_0: i8 = 0b0111_1111;
    const ptr_0: *i8 = &val_i8_0;
    println_fn("ptr_0.*", ptr_0.*);
    ptr_0.* = -128;
    println_fn("val_i8_0", val_i8_0);

    var vec_0: @Vector(16, u32) = @splat(16);
    const ptr_1: *@Vector(16, u32) = &vec_0;
    ptr_1.*[0] = 32;
    print("vec_0[0] ---> {d}\n", .{vec_0[0]});

    var array_0 = [5]u16{ 1, 2, 3, 4, 5 };
    const ptr_2: [*]u16 = &array_0;
    ptr_2[0] = std.math.maxInt(u16);
    print("array[0] ---> {d}\n", .{array_0[0]});

    const ptr_3: *i32 = @ptrFromInt(0xdeadbee0);
    const addr = @intFromPtr(ptr_3);
    if (@TypeOf(addr) == usize and addr == 0xdeadbee0) {
        println_fn("Successed ptr 0xdeadbee0", addr);
    }
}
