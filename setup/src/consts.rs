pub const URL: &str = "https://github.com/jewlexx/dotfiles.git";

pub const fn is_win() -> bool {
    cfg!(target_os = "windows")
}
pub const fn is_dev() -> bool {
    cfg!(debug_assertions)
}
