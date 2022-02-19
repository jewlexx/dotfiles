use super::{
    consts::*,
    repo::{get_clone_dir, RepoError},
};
use spinners_rs::{Spinner, Spinners};
#[cfg(not(target_os = "windows"))]
use std::os::unix::fs;
use std::{
    fs as fs_std,
    process::Command,
    sync::Arc,
    thread::{self, JoinHandle},
};

pub fn create_spinner(message: &str) -> Spinner {
    Spinner::new(Spinners::Dots, String::from(message))
}

pub fn get_password() -> Option<String> {
    match rpassword::read_password_from_tty(Some("Please enter the admin password: ")) {
        Ok(p) => {
            if p.is_empty() {
                println!("Password cannot be empty");
                None
            } else {
                Some(p)
            }
        }
        Err(e) => {
            panic!("Error: {:?}", e.to_string());
        }
    }
}

pub fn check_password(password: &str) -> Option<bool> {
    Command::new(CMD)
        .arg("-c")
        .arg(format!("echo {}", password))
        .arg("|")
        .arg("sudo -S echo")
        .output()
        .ok()
        .map(|output| output.status.success())
}

#[cfg(target_os = "windows")]
pub fn link_files() {
    println!("Not implemented on windows");
}

#[cfg(not(target_os = "windows"))]
pub fn link_files() -> Result<(), RepoError> {
    use std::path::Path;

    let clone_dir = get_clone_dir()?.into_os_string().into_string().unwrap();
    let shared_dir = Arc::new(clone_dir);

    let mut threads: Vec<JoinHandle<std::io::Result<()>>> = Vec::new();

    for file in DOTFILES {
        let dir = Arc::clone(&shared_dir);
        let thread = thread::spawn(move || {
            let path = format!("{}/{}", dir, file);
            let target_path = format!("{}/.{}", dir, file);

            if Path::new(&target_path).exists() {
                fs_std::remove_file(&target_path)?;
            }

            fs::symlink(path, target_path)
        });

        threads.push(thread);
    }

    for thread in threads {
        thread.join().unwrap().unwrap();
    }

    Ok(())
}
