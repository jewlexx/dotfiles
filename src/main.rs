use git2::Repository;
use home::home_dir;
use rpassword::read_password_from_tty;
use spinners::{Spinner, Spinners};
use std::{env, process::Command};
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

    let passwd = read_password_from_tty(Some("Root password: ")).unwrap();

    let mut sp = Spinner::new(&Spinners::Dots, "Cloning Repository".into());

    match Repository::clone(url, clone_dir) {
        Ok(repo) => repo,
        Err(e) => panic!("failed to clone: {}", e),
    };

    sp.stop();

    sp = Spinner::new(
        &Spinners::Dots,
        "Upgrading system pacakges (this may take a while)".into(),
    );

    let installcmd = format!(
        "echo {} | sudo --stdin pacman -Syu base-devel zip unzip yay git curl zsh --noconfirm",
        passwd
    );

    Command::new("sh")
        .arg("-c")
        .arg(installcmd)
        .output()
        .expect("failed to upgrade system packages");

    sp.stop();
}
