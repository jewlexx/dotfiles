use crate::{
    sys::package::{get_pacman, PackageManager},
    utils::git::clone_repo,
};

#[macro_use]
extern crate lazy_static;

#[macro_use]
extern crate anyhow;

mod sys;
mod utils;

fn main() -> anyhow::Result<()> {
    println!("Started cloning repository...");
    let repo_task = clone_repo();

    let (pacman, pacman_path) = get_pacman().destructure();

    let nu_task = smol::spawn(async move {
        match pacman {
            PackageManager::Scoop(_) => pacman.install("nu"),
            _ => pacman.install("nushell"),
        }
    });

    println!("{}", pacman_path);

    Ok(())
}
