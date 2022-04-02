use git2::Repository;

use crate::consts::URL;
use crate::user::dotfiles_dir;

pub trait ErrorMsg {
    fn msg(&self) -> String;
}

impl ErrorMsg for RepoError {
    fn msg(&self) -> String {
        match self {
            RepoError::NotFound(msg) => msg.to_owned(),
            RepoError::DirExists(msg) => msg.to_owned(),
            RepoError::Git(msg) => msg.to_owned(),
        }
    }
}

#[derive(Debug)]
pub enum RepoError {
    NotFound(String),
    DirExists(String),
    Git(String),
}

pub fn clone_repo() -> Result<Repository, RepoError> {
    let clone_dir = match dotfiles_dir() {
        Some(v) => v,
        None => return Err(RepoError::NotFound("Dotfiles directory not found".into())),
    };

    if clone_dir.exists() {
        return Err(RepoError::DirExists(
            "Dotfiles directory already exists".into(),
        ));
    }

    Repository::clone(URL, clone_dir).map_err(|e| RepoError::Git(e.message().to_string()))
}
