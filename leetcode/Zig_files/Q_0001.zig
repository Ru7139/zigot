const std = @import("std");

const expect = std.testing.expect;
const assert = std.debug.assert;
const print = std.debug.print;
const mem_euqal = std.mem.eql;

const normal_error = error{ EmptyArray, CombinationNotFoundInArray };

pub fn main() !void {
    const time_start = std.time.nanoTimestamp();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const timestamp_seed = @as(u64, @intCast(std.time.timestamp()));
    var XS_256_RNG = std.Random.Xoshiro256.init(timestamp_seed);

    var temp_timer: i128 = 0;

    for (0..1_000) |_| {
        const arr_1: []u64 = try give_the_Q1_array(allocator, 1_000, 3, 78, &XS_256_RNG);
        defer allocator.free(arr_1);

        const t1 = std.time.nanoTimestamp();
        const answer = try find_Q1_combination(allocator, u64, arr_1, arr_1[0] + arr_1[arr_1.len - 1]);
        _ = answer;
        const t2 = std.time.nanoTimestamp();
        temp_timer += t2 - t1;
    }

    // 单线程，最坏结果，包含生成数组与寻找结果
    // 1_000_000次10个数字的组合，需要44_812_861_000ns，约45s
    // 100_000次100个数字的组合，需要12_378_246_000ns，约12s
    // 10_000次1_000个数字的组合，需要6_807_997_000ns，约7s
    // 1_000次10_000个数字的组合，需要4_929_751_000ns，约5s
    // 1_000次100_000个数字的组合，需要44_741_483_000ns，约45s
    // 1_000次1_000个数字的组合，需要686_108_000ns，约0.7s
    //
    // 采用直接跳过大于target的数的算法时
    // times = 1_000 ---> nums = 1_000_000  ---> 1.296372s(8.630629s)   ---> 15%
    // times = 1_000 ---> nums = 1_000      ---> 20.177ms(45.899ms)     ---> 44%

    // dispaly_the_array(u64, arr_1);
    // print("{any}\n", .{answer});

    const time_end = std.time.nanoTimestamp();
    print("time1 ---> {}\n", .{time_end - time_start});
    print("time2 ---> {}\n", .{temp_timer});
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

fn find_Q1_combination(allocator: std.mem.Allocator, comptime T: type, array: []T, target: T) ![2]usize {
    // 要求不存在负数
    // 这个算法是为两个正整数相加而设计的
    // 如果有负数存在，则应该删除continue那里
    //
    // 理由是正整数存在着下限，若大于则不可能通过相加而获得

    comptime {
        if (@typeName(T)[0] != 'u') @compileError("find_Q1_combination only accepts unsigned integer types.");
    }

    var hmap = std.hash_map.AutoHashMap(T, usize).init(allocator);
    defer hmap.deinit();

    for (array, 0..) |value, index| {
        if (value > target) {
            continue;
        } else if (hmap.get(target - value)) |found_it_index| {
            return [2]usize{ found_it_index, index };
        } else {
            try hmap.put(value, index);
        }
    }

    return error.CombinationNotFoundInArray;
}
