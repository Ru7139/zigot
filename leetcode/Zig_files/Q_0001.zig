const std = @import("std");

const expect = std.testing.expect;
const assert = std.debug.assert;
const print = std.debug.print;
const mem_euqal = std.mem.eql;

const normal_error = error{
    EmptyArray,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const u64_seed = @as(u64, @intCast(std.time.timestamp()));
    var XS_256_RNG = std.Random.Xoshiro256.init(u64_seed);

    const arr_1: []u64 = try give_the_Q1_array(allocator, 24, 3, 77, &XS_256_RNG);
    defer allocator.free(arr_1);

    dispaly_the_array(u64, arr_1);
}

fn dispaly_the_array(comptime T: type, array: []T) void {
    for (0..array.len) |i| print("array[{:2}] ---> {}\n", .{ i, array[i] });
}

fn give_the_Q1_array(allocator: std.mem.Allocator, arr_len: usize, first_value: u64, last_value: u64, u64_RNG: *std.Random.Xoshiro256) ![]u64 {
    if (arr_len == 0) return error.EmptyArray;

    var arr = try allocator.alloc(u64, arr_len);

    arr[0] = first_value;
    arr[(arr.len - 1)] = last_value;

    for (arr[1..((arr.len - 1))]) |*i| {
        i.* = u64_RNG.next();
        while (i.* == last_value) {
            i.* = u64_RNG.next();
        }
    }

    return arr;
}

// fn find_Q1_combination(comptime T: type, array: []T) [2]usize {}
