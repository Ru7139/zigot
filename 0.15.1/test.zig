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

test "1.2 ---> basic types" {
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
}
