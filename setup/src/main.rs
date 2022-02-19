mod utils;
use std::thread;
use utils::*;

fn main() {
    let repo_thread = thread::spawn(move || -> git2::Repository {
        let sp = system::create_spinner("Cloning repo...");
        let v = match repo::clone_repo() {
            Ok(repo) => {
                println!("Cloned repo");
                repo
            }
            Err(e) => {
                panic!("Error: {:?}", e.to_string());
            }
        };

        sp.stop_with_message(String::from("Cloned repo!"));

        v
    });

    let password = system::get_password();
    if password.is_none() {
        panic!("Error: Password cannot be empty");
    } else if !system::check_password(&password.unwrap()).unwrap() {
        panic!("Error: Password is invalid");
    }

    let sp = system::create_spinner("Linking files...");
    match system::link_files() {
        Ok(_) => println!("Linked files"),
        Err(e) => panic!("Error: {:?}", e.to_string()),
    };
    sp.stop_with_message(String::from("Finished linking files!\n"));

    let repo = repo_thread.join().unwrap();
}
