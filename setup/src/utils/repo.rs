use super::consts::*;
use dirs::home_dir;
use git2::Repository;
use std::fmt;

pub enum RepoError {
    GetHome,
    PathExists,
    Clone,
}

impl fmt::Display for RepoError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            RepoError::GetHome => write!(f, "Could not get home directory"),
            RepoError::PathExists => write!(f, "Path already exists"),
            RepoError::Clone => write!(f, "Could not clone repo"),
        }
    }
}

pub fn clone_repo() -> Result<Repository, RepoError> {
    let mut home = match home_dir() {
        Some(path) => path,
        None => return Err(RepoError::GetHome),
    };

    home.push("dotfiles");

    if home.exists() {
        Err(RepoError::PathExists)
    } else {
        let repo = match Repository::clone(URL, &home) {
            Ok(repo) => repo,
            Err(_) => return Err(RepoError::Clone),
        };

        Ok(repo)
    }
}
