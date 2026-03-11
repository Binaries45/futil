const std = @import("std");

const DupTable = struct {
    /// a mapping of the file math to its path
    known_files: std.HashMap(u64, [:0]const u8),
    /// a mapping of file hashes to all files with the hash.
    ///
    /// when a duplicate file is found, all paths are added to this map
    dupes: std.HashMap(u64, std.ArrayList([:0]const u8))
};

pub fn dedup(alloc: std.mem.Allocator, path: [:0]const u8) !void {
    // walk the dir
    const dir = try std.fs.cwd().openDir(path, .{ .iterate = true });
    var walker = try std.fs.Dir.walk(dir, alloc);
    defer walker.deinit();

    while (try walker.next()) |entry| {
        // for each file path, compute its hash, and compare it to known hashes
        // if collision is found, add both of the corresponding
        // paths to list of known dupes
        _ = entry;
    }

    // print all paths to duplicates once all files are checked

    return error.todo;
}