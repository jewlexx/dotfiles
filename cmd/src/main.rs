mod consts;

use spinners::{Spinner, Spinners};
use std::{
    io::{stdout, Write},
    thread,
    time::Duration,
};

fn main() {
    let user_dirs = directories::UserDirs::new().unwrap();
    let home_dir = user_dirs.home_dir();
    let dotfiles_dir = home_dir.join("dotfiles");

    let sp = Spinner::new(Spinners::Dots, "Cloning dotfiles repo".into());
    let _repo = match git2::Repository::clone(consts::GITHUB_URL, &dotfiles_dir) {
        Ok(repo) => {
            sp.stop_with_message("Successfully cloned!".into());
            Some(repo)
        }
        Err(e) => {
            sp.stop_with_message(format!("Failed to clone repo: {}\n", e.message()));
            let mut stdout = stdout();
            for i in (1..6).rev() {
                print!("\rContinuing with existing repo in {} seconds...", i);
                stdout.flush().unwrap();
                thread::sleep(Duration::from_secs(1));
            }
            println!("\rContinuing with existing repo in 0 seconds...");
            None
        }
    };

    println!("Hello, world!");
}
