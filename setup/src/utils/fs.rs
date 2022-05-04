#[cfg(target_os = "windows")]
pub use std::os::windows::fs::symlink_file as symlink;

#[cfg(not(target_os = "windows"))]
pub use std::os::unix::fs::symlink;

use std::{fs, path::PathBuf};

pub fn symlink_dir(from: PathBuf, to: PathBuf) -> anyhow::Result<()> {
    let dir = fs::read_dir(from)?;

    for entry in dir {
        let entry = entry?;
        let path = entry.path();
        if !path.is_dir() {
            symlink(path, to.clone())?;
        } else {
            symlink_dir(path.clone(), to.join(path))?;
        }
    }

    Ok(())
}
