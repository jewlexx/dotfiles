pub const URL: &str = "https://github.com/jewlexx/dotfiles.git";

#[cfg(target_os = "windows")]
pub const CMD: &str = "cmd.exe";

#[cfg(not(target_os = "windows"))]
pub const CMD: &str = "sh";

pub const DOTFILES: [&str; 3] = ["zshrc", "gitconfig", "gitignore"];
