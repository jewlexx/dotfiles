use super::{consts::*, system::get_clone_dir};
use dirs::home_dir;
use git2::Repository;
use std::{env, fmt};

#[derive(Debug)]
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
    let home = get_clone_dir()?;

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
