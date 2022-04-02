use directories::UserDirs;
use std::path::PathBuf;

use crate::consts::is_dev;

fn home_dir() -> Option<PathBuf> {
    if let Some(dirs) = UserDirs::new() {
        let home = dirs.home_dir().to_path_buf();
        Some(home)
    } else {
        None
    }
}

pub fn dotfiles_dir() -> Option<PathBuf> {
    if let Some(home) = home_dir() {
        let appendage = if is_dev() {
            ".dotfiles-dev"
        } else {
            ".dotfiles"
        };
        let dir = home.join(appendage);

        Some(dir)
    } else {
        None
    }
}
