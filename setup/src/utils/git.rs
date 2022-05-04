use git2::Repository;

use crate::utils::fs::DOTFILES;

pub const GIT_URL: &str = "https://github.com/jewlexx/dotfiles.git";

pub fn clone_repo() -> smol::Task<Result<Repository, git2::Error>> {
    let r = smol::spawn(async { Repository::clone(GIT_URL, DOTFILES.clone()) });

    println!("Finished cloning repository!");

    r
}
