const std = @import("std");

pub fn main() !void {
    const StdOut = std.io.getStdOut().writer();

    const start_time = std.time.nanoTimestamp();

    const a: u32 = 10;
    const b: u32 = 20;
    try StdOut.print("a = {}, b = {}\n", .{ a, b });

    const c1: u8 = 65;
    const c2: u8 = 'A';
    std.debug.assert(c1 == c2);

    const d1: u8 = 66;
    const d2: u8 = 'B';
    try StdOut.print("\nd1 = {c}, d2 = {}\n", .{ d1, d2 });

    const e = "Here is zig language";
    try StdOut.print("\ne: type = {}\n", .{@TypeOf(e)});
    try StdOut.print("e: length = {}\n", .{e.len});
    try StdOut.print("e: content = {s}\n", .{e});
    try StdOut.print("e: last character = {c}\n", .{e[e.len - 1]});

    const f1 = [_]u32{ 1, 2, 3, 4, 5 };
    try StdOut.print("\nf1: type = {}\n", .{@TypeOf(f1)});
    try StdOut.print("f1: len = {}\n", .{f1.len});
    try StdOut.print("f1: content = {any}\n", .{f1});

    const g1 = [_][]const u8{ "Apple", "Banana", "Cherry" };
    try StdOut.print("\ng1: type = {}\n", .{@TypeOf(g1)});
    try StdOut.print("g1: len = {}\n", .{g1.len});
    try StdOut.print("g1: content = {s}\n", .{g1});

    const vec1 = @Vector(6, u32){ 10, 13, 17, 22, 28, 35 };
    const vec2 = @Vector(6, u32){ 1, 3, 5, 7, 9, 11 };
    const vec3 = vec1 + vec2; // value will be added, same type as themselves
    try StdOut.print("\nvec3: type = {}\n", .{@TypeOf(vec3)});
    try StdOut.print("vec3: len = {}\n", .{@typeInfo(@TypeOf(vec3)).vector.len});
    try StdOut.print("vec3: content = {any}\n", .{vec3});
    // if add @Vector(6, u32) with @Vector(5, u32), it will get an error
    //      const vec3 = vec1 + vec2;
    //                   ~~~~~^~~~~~ (error: vector length mismatch)
    //      const vec3 = vec1 + vec2;
    //                   ^~~~ (length 6 here)
    //      const vec3 = vec1 + vec2;
    //                          ^~~~ length 5 here

    var value1: u32 = 10;
    const point1: *u32 = &value1;
    point1.* = 50;
    try StdOut.print("\npoint1 = {d}\nvalue1 = {d}\n", .{ point1, value1 });

    const array1 = [_]u32{ 2, 3, 4, 5, 6 };
    const array2 = array1[1..4];
    try StdOut.print("\n{}\n", .{@TypeOf(array1)});
    try StdOut.print("{d}\n", .{array1});
    try StdOut.print("{}\n", .{@TypeOf(array2)});
    try StdOut.print("{d}\n", .{array2});

    const Rocket = struct {
        destination: []const u8,
        code: u8,
        index: u32,
    };

    const rocket_solar = Rocket{ .destination = "Atlantic", .code = 'U', .index = 9052 };
    try StdOut.print("\nrocket_solar: type = {}\n", .{@TypeOf(rocket_solar)});
    try StdOut.print("rocket_solar.destination = {s}\n", .{rocket_solar.destination});
    try StdOut.print("rocket_solar.code = {c}\n", .{rocket_solar.code});
    try StdOut.print("rocket_solar.index = {d}\n", .{rocket_solar.index});

    const ship_rock = .{ .ship_type = "FPSO", .destination = "New York", .code = 'P', .index = 2105 };
    try StdOut.print("\nship_rock: type = {}\n", .{@TypeOf(ship_rock)});
    try StdOut.print("ship_rock.type = {s}\n", .{ship_rock.ship_type});
    try StdOut.print("ship_rock.destination = {s}\n", .{ship_rock.destination});
    try StdOut.print("ship_rock.code = {c}\n", .{ship_rock.code});
    try StdOut.print("ship_rock.index = {d}\n", .{ship_rock.index});

    const final_elapsed_time_ns: i128 = std.time.nanoTimestamp() - start_time; // i128除法需要配置
    std.debug.print("\nExec Done with --> {}ns\n", .{final_elapsed_time_ns});
}
