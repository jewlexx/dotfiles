use git2::Repository;

use crate::utils::fs::DOTFILE;

pub const GIT_URL: &str = "https://github.com/jewlexx/dotfiles.git";

pub fn clone_repo() -> smol::Task<Result<Repository, git2::Error>> {
    smol::spawn(async { Repository::clone(GIT_URL, DOTFILES.clone()) })
}
