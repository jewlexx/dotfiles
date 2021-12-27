use git2::Repository;
use home::home_dir;
use rpassword::read_password_from_tty;
use spinners::{Spinner, Spinners};
use std::{
    env,
    io::Result,
    process::{Command, Output},
};
use sys_info::linux_os_release;

fn run_cmd(cmd: &str) -> Result<Output> {
    Command::new("sh").arg("-c").arg(cmd).output()
}

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
        "Upgrading and installing system packages (this may take a while)".into(),
    );

    let installcmd = format!(
        "echo {} | sudo --stdin pacman -Syu base-devel zip unzip yay git curl zsh --noconfirm",
        passwd
    );

    run_cmd(&installcmd).expect("failed to upgrade system packages");

    run_cmd("$(curl -fsSL https://get.sdkman.io)").expect("failed to install sdkman");

    run_cmd("sdk install java 17.0.1-open").expect("failed to install java");

    run_cmd("sdk install gradle").expect("failed to install gradle");

    sp.stop();

    sp = Spinner::new(&Spinners::Dots, "Installing oh-my-zsh and friends".into());

    let mut cmd =
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";

    run_cmd(cmd).expect("failed to install oh-my-zsh");

    cmd = "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k";
    run_cmd(cmd).expect("failed to install p10k");
    cmd = "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting";
    run_cmd(cmd).expect("failed to install syntax highlighting");
    cmd = "git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions";
    run_cmd(cmd).expect("failed to install suggestions");

    sp.stop();
}
