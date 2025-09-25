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

    // 各种显式强制转换
    // @enumFromInt(integer: anytype)
    // @errorCast(value: anytype)
    // @floatCast(value: anytype)
    // @floatFromInt(int: anytype)
    // @intCast(int: anytype)
    // @intfrom____
    // @ptrFromInt(address: usize)
    // @ptrCast(value: anytype)
    // @truncate(integer: anytype)
}

test "2.2 memory management" {
    {
        // DebugAllocator
        // 在debug模式下使用这个分配器
        // 线程安全检查，安全检查，内存泄漏检查等特性，均可以手动配置是否开启
        var gpa = std.heap.DebugAllocator(.{}){};
        const allocator = gpa.allocator();

        defer {
            const deinit_status = gpa.deinit(); // 尝试进行 deinit 操作
            if (deinit_status == .leak) @panic("test fail"); // 检查是否发生内存泄漏
        }

        const bytes = try allocator.alloc(u8, 100); // 申请内存
        defer allocator.free(bytes); // 延后释放内存
    }

    {
        // SmpAllocator 转为ReleaseFast优化的分配器，启用多线程
        // 这个分配器是个单例，使用全局状态，整个过程只应实体化一个
        //
        // 设计思路：
        //
        // 1
        // 每个线程都有独立的freelist，当线程推出时，数据必须可回收。
        // 由于不知道线程合适退出，所以偶尔需要一个线程尝试回收其他线程的资源
        //
        // 2
        // 超过特定大小的内存分配会直接通过memory mapped（内存映射）实现，且不存储分配元数据。
        //
        // 3
        // 每个分配器操作都会通过线程局部变量检查线程标识符，去确定访问全局状态中的哪个元素，并尝试获取其锁。
        // 除非被另一个线程分配了同样的ID，否则，都应该成功
        // 如果发生竞争，线程会移动到下一个线程元数据槽位并重复尝试获取锁的过程
        //
        // 4
        // 通过将线程局部元数据组限制为与CPU数量相同的大小，确保了线程的创建与销毁
        // 他们会循环使用整个空闲列表集合
        //
        const allocator_smpA = std.heap.smp_allocator;
        const bytes_smpA = try allocator_smpA.alloc(u8, 100);
        defer allocator_smpA.free(bytes_smpA);
    }
}

test "2.3 comptime" {}

test "2.4 reflection" {}

test "2.5 asynchronous" {}

test "2.6 assmbly" {}

test "2.7 atomic operation" {}

test "2.8 ffi interactive with c language" {}

test "2.9 undefined operation" {}
