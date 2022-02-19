mod utils;
use std::thread;
use utils::*;

fn main() {
    let repo_thread = thread::spawn(move || -> Option<git2::Repository> {
        match repo::clone_repo() {
            Ok(repo) => {
                println!("Cloned repo");
                Some(repo)
            }
            Err(e) => {
                panic!("Error: {:?}", e.to_string());
            }
        }
    });

    let repo = repo_thread.join().unwrap();
}
