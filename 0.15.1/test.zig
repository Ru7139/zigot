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
