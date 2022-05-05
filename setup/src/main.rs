use crate::{sys::package::get_pacman, utils::git::clone_repo};

#[macro_use]
extern crate lazy_static;

mod sys;
mod utils;

fn main() -> anyhow::Result<()> {
    println!("Started cloning repository...");
    let repo_task = clone_repo();

    let pacman = get_pacman();

    let s = String::from(pacman);

    Ok(())
}
