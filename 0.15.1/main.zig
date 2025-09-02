const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;

pub fn main() !void {

    // print
    try std.fs.File.stdout().writeAll("Hello");
    print(" {s}\n", .{"World!"});

    // i32 & f32 & value form convert
    const i32_val_example: i32 = 23 + 37;
    const f32_val_example: f32 = @as(f32, i32_val_example) / std.math.pi;
    print("i32: {}, f32: {}\n", .{ i32_val_example, f32_val_example });

    // bool & if
    const and_process: bool = true and false;
    const or_process: bool = true or false;
    if (and_process == or_process) {
        print("Something not right\n", .{});
    } else {
        print("and process, one false is false\n", .{});
        print("or process, one true is true\n", .{});
    }

    // var & optional & assert
    var opt_u8_array: ?[]const u8 = null;
    opt_u8_array = "Hi";
    assert(opt_u8_array != null);

    // anyerror type
    var error_val_example: anyerror!i32 = error.ArgNotFound;
    print("error_val_example.type = {}, val = {!}\n", .{ @TypeOf(error_val_example), error_val_example });
    error_val_example = 2345;
    print("error_val_example.type = {}, val = {!}\n", .{ @TypeOf(error_val_example), error_val_example });

    const vec_3x3_example: [3][3]u8 = .{ .{ 1, 2, 3 }, .{ 1, 2, 3 }, .{ 1, 2, 3 } };
    print("{any}", .{vec_3x3_example});
}

const CosmosRocket = struct {
    index: u16,
};
