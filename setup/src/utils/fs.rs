#[cfg(target_os = "windows")]
pub use std::os::windows::fs::symlink_file as symlink;

#[cfg(not(target_os = "windows"))]
pub use std::os::unix::fs::symlink;
