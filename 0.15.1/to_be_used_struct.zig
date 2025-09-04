pub const PrimitiveTypesStruct = struct {
    void_type: void,
    bool_type: bool,
    // anyopaque_type: anyopaque, // for type-erased poninters
    // noreturn_type: noreturn, // break, continue, unreachable
    type_type: type, // type of types
    // error_type: anyerror, // an error code
    // int
    // int_8_: i8,
    // int_16_: i16,
    // int_32_: i32,
    // int_64_: i64,
    // int_128_: i128,
    int_pointer_sized: isize,
    // unsigned_int
    // unsigned_8_: u8,
    // unsigned_16_: u16,
    // unsigned_32_: u32,
    // unsigned_64_: u64,
    // unsigned_128_: u128,
    unsigned_pointer_sized: usize,
    // float
    // float_16_: f16,
    float_32_: f32,
    // float_64_: f64,
    // float_80_: f80, // long double
    // float_128: f128,
    // for ABI compatibility with C
    // the_c_char: c_char,
    // the_c_short: c_short,
    // the_c_ushort: c_ushort,
    // the_c_int: c_int,
    // the_c_uint: c_uint,
    // the_c_long: c_long,
    // the_c_ulong: c_ulong,
    // the_c_longlong: c_longlong,
    // the_c_longdouble: c_longdouble,
    // comptime                 // only allow for comptime-known values
    // compile_time_int: comptime_int,
    compile_time_float: comptime_float,
};
