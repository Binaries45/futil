const std = @import("std");

pub fn list(alloc: std.mem.Allocator, path: [:0]const u8) !void {
    // set up dir walker
    const dir = try std.fs.cwd().openDir(path, .{ .iterate = true });
    var walker = try std.fs.Dir.walk(dir, alloc);
    defer walker.deinit();

    // print out all file paths alongside their sizes
    std.debug.print("{s:<20} {s:<20}\n", .{"SIZE", "PATH"});
    std.debug.print("{s:_>20} {s:_<20}\n", .{"", ""});
    while (try walker.next()) |entry| {
        if (entry.kind != .file) continue;
        const stat = try entry.dir.statFile(entry.basename);
        std.debug.print("{d:>20} {s:<20}\n", .{stat.size, entry.path});
    }
}