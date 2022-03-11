mod consts;

use consts::*;
use directories::UserDirs;
use std::{
    fs,
    io::{stdout, Write},
    path::PathBuf,
    str::FromStr,
    sync::Arc,
    thread,
    time::Duration,
};
use threadpool::ThreadPool;

fn clone_repo(dotfiles_dir: &Arc<PathBuf>, pool: &ThreadPool) {
    let cloned_dir = Arc::clone(dotfiles_dir);
    pool.execute(move || {
        let _repo = match git2::Repository::clone(GITHUB_URL, cloned_dir.as_path()) {
            Ok(repo) => {
                println!("Successfully cloned!");
                Some(repo)
            }
            Err(e) => {
                println!("Failed to clone repo: {}\n", e.message());
                None
            }
        };
    });
}

fn main() {
    let pool = threadpool::Builder::new().build();
    let user_dirs = UserDirs::new().unwrap();
    let home_dir = user_dirs.home_dir();
    let dotfiles_dir = Arc::new(home_dir.join("dotfiles"));

    if Arc::clone(&dotfiles_dir).exists() {
        println!("Dotfiles already exists!");
        let mut stdout = stdout();
        for i in (1..6).rev() {
            print!("\rContinuing with existing repo in {} seconds...", i);
            stdout.flush().unwrap();
            thread::sleep(Duration::from_secs(1));
        }
        println!("\rContinuing with existing repo in 0 seconds...");
    }

    clone_repo(&dotfiles_dir, &pool);
}
