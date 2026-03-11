const std = @import("std");

pub fn list(alloc: std.mem.Allocator, path: [:0]const u8) !void {
    const dir = try std.fs.cwd().openDir(path, .{ .iterate = true });
    var walker = try std.fs.Dir.walk(dir, alloc);
    defer walker.deinit();

    var buf: [64 * 1024]u8 = undefined;
    var stdout = std.fs.File.stdout().writer(&buf);
    const writer = &stdout.interface;

    while (try walker.next()) |entry| {
        if (entry.kind != .file) continue;

        try writer.print("{s:<20}\n", .{
            entry.path,
        });
    }

    try writer.flush();
}