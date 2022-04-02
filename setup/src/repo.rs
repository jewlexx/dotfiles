use git2::Repository;

use crate::consts::*;
use crate::user::dotfiles_dir;

#[derive(Debug)]
pub enum RepoError {
    NotFound,
    DirExists,
    Git(git2::Error),
}

pub fn clone_repo() -> Result<Repository, RepoError> {
    let clone_dir = match dotfiles_dir() {
        Some(v) => v,
        None => return Err(RepoError::NotFound),
    };

    let url = URL;

    if clone_dir.exists() {
        return Err(RepoError::DirExists);
    }

    Repository::clone(url, clone_dir).map_err(RepoError::Git)
}