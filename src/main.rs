use git2::Repository;
use home::home_dir;
use std::env;
use sys_info::linux_os_release;

fn main() {
    let release = linux_os_release().unwrap();
    let distro = release.id.unwrap();
    let pretty_name = release.pretty_name.unwrap();

    println!("Running on: {}", pretty_name);

    if distro != "manjaro" {
        panic!("unsupported operating system!");
    }

    let url = "https://github.com/jamesinaxx/dotfiles.git";
    let mut clone_dir = home_dir().unwrap();

    let args: Vec<String> = env::args().collect();
    let passed_dir = args.get(1);

    if passed_dir.is_none() {
        clone_dir.push("dotfiles");
    } else {
        clone_dir.push(passed_dir.unwrap())
    }

    match Repository::clone(url, clone_dir) {
        Ok(repo) => repo,
        Err(e) => panic!("failed to clone: {}", e),
    };

    println!("Finished cloning repository");
}
