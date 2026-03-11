const std = @import("std");
const Operation = @import("operations/op.zig").Operation;
const list = @import("operations/list.zig").list;
const dedup = @import("operations/dedup.zig").dedup;

pub fn main() !void {
    var gpa = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer gpa.deinit();
    const alloc = gpa.allocator();

    var args = try std.process.ArgIterator.initWithAllocator(alloc);
    defer args.deinit();

    // skip the call location
    _ = args.next();

    // expect first arg to be the operation
    const op = std.meta.stringToEnum(
        Operation,
        args.next() orelse return error.ExpectedOperation
    ) orelse return error.InvalidOperation;

    // next is the options for the given operation
    switch (op) {
        .list => {
            const path = args.next() orelse return error.ExpectedPathForDedup;
            try list(alloc, path);
        },
        .dedup => {
            const path = args.next() orelse return error.ExpectedPathForDedup;
            try dedup(alloc, path);
        },
    }
}