use git2::Repository;
use home::home_dir;
use sys_info::linux_os_release;

fn main() {
    let release = linux_os_release().unwrap();
    let distro = release.id.unwrap();
    let pretty_name = release.name.unwrap();

    println!("Running on: {}", pretty_name);

    if distro != "manjaro" {
        panic!("unsupported operating system!");
    }

    let url = "https://github.com/jamesinaxx/dotfiles.git";
    let mut clone_dir = home_dir().unwrap();
    clone_dir.push("dotfiles");

    let repo = match Repository::clone(url, clone_dir) {
        Ok(repo) => repo,
        Err(e) => panic!("failed to clone: {}", e),
    };
}
