use git2::Repository;

use crate::{utils::fs::DOTFILES, GIT_URL};

pub fn clone_repo() -> smol::Task<Result<Repository, git2::Error>> {
    smol::spawn(async { Repository::clone(GIT_URL, DOTFILES.clone()) })
}
