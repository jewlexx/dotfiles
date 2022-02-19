use super::consts::*;
use dirs::home_dir;
use git2::Repository;
use std::{env, fmt, path::PathBuf};

#[derive(Debug)]
pub enum RepoError {
    GetHome,
    PathExists,
    Clone,
}

pub fn get_clone_dir() -> Result<PathBuf, RepoError> {
    let mut home = if let Some(path) = home_dir() {
        path
    } else {
        return Err(RepoError::GetHome);
    };

    if let Some(path) = env::args().nth(1) {
        home.push(path)
    } else {
        home.push("dotfiles");
    }

    Ok(home)
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
