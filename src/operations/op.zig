pub const Operation = enum(u8) {
    /// list out all file paths
    ///
    /// usage : `futil list "path/to/dir"`
    list,
    /// deduplicate files, logging all duplicated found
    ///
    /// usage : `futil dedup "path/to/dir"`
    dedup,
};