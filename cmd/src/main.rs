mod consts;

use std::{
    fs,
    io::{stdout, Write},
    path::PathBuf,
    str::FromStr,
    sync::Arc,
    thread,
    time::Duration,
};

fn main() {
    let pool = threadpool::Builder::new().build();
    let user_dirs = directories::UserDirs::new().unwrap();
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

    {
        let cloned_dir = Arc::clone(&dotfiles_dir);
        pool.execute(move || {
            let _repo = match git2::Repository::clone(consts::GITHUB_URL, cloned_dir.as_path()) {
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

    {
        let cloned_dir = Arc::clone(&dotfiles_dir);
        pool.execute(move || {
            let mut antigen_dir =
                PathBuf::from_str(cloned_dir.as_os_str().to_str().unwrap()).unwrap();
            antigen_dir.push("utils");
            antigen_dir.push("antigen.zsh");

            let client = reqwest::blocking::Client::new();

            let antigen_file = client
                .get(consts::ANTIGEN_URL)
                .send()
                .unwrap()
                .text()
                .unwrap();

            fs::write(antigen_dir.as_path(), antigen_file).unwrap();
        });
    }

    println!("Hello, world!");
}
