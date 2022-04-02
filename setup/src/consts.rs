pub const URL: &str = "https://github.com/jewlexx/dotfiles.git";

pub struct Environment {
    pub dev: bool,
    pub win: bool,
}

const fn is_win() -> bool {
    cfg!(target_os = "windows")
}

const fn is_dev() -> bool {
    cfg!(debug_assertions)
}

pub const fn get_environment() -> Environment {
    Environment {
        dev: is_dev(),
        win: is_win(),
    }
}
