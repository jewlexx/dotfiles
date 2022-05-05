use git2::ErrorCode;

use crate::{
    sys::package::{get_pacman, PackageManager},
    utils::git::clone_repo,
};

#[macro_use]
extern crate duct;

#[macro_use]
extern crate lazy_static;

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

    smol::block_on(async {
        nu_task.await?;
        let e = repo_task.await.err();

        if let Some(e) = e {
            if e.code() == ErrorCode::Exists {
                println!("Repository already exists.");
            } else {
                return Err(e.into());
            }
        }

        Ok::<(), anyhow::Error>(())
    })?;

    Ok(())
}
