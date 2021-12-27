use git2::Repository;
use home::home_dir;
use rpassword::read_password_from_tty;
use spinners::{Spinner, Spinners};
use std::{env, process::Command};
use sys_info::linux_os_release;

fn run_cmd(cmd: &str, err: &str) {
    Command::new("sh").arg("-c").arg(cmd).output().expect(err);
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

    run_cmd(&installcmd, "failed to upgrade system packages");

    run_cmd(
        "$(curl -fsSL https://get.sdkman.io)",
        "failed to install sdkman",
    );

    run_cmd("sdk install java 17.0.1-open", "failed to install java");

    run_cmd("sdk install gradle", "failed to install gradle");

    sp.stop();

    sp = Spinner::new(&Spinners::Dots, "Installing oh-my-zsh and friends".into());

    let mut cmd =
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";

    run_cmd(cmd, "failed to install oh-my-zsh");

    cmd = "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k";
    run_cmd(cmd, "failed to install p10k");
    cmd = "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting";
    run_cmd(cmd, "failed to install syntax highlighting");
    cmd = "git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions";
    run_cmd(cmd, "failed to install suggestions");

    sp.stop();

    sp = Spinner::new(&Spinners::Dots, "Installing NodeJS".into());

    run_cmd(
        "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh)",
        "failed to install nvm",
    );

    run_cmd("nvm install --lts", "failed to install lts NodeJS");
    run_cmd("nvm install node", "failed to install latest NodeJS");
    run_cmd("nvm use --lts", "failed to set to use lts NodeJS");
    run_cmd("npm i -g yarn", "failed to install yarn globally");

    sp.stop();

    let ln_cmd = format!(
        "echo {} | sudo --stdin ln -s /var/lib/snapd/snap /snap",
        passwd
    );

    run_cmd(&ln_cmd, "failed to symlink for classic snaps");

    let mut dir = home_dir().unwrap();

    let args: Vec<String> = env::args().collect();
    let passed_dir = args.get(1);

    if passed_dir.is_none() {
        dir.push("dotfiles");
    } else {
        dir.push(passed_dir.unwrap())
    }

    let install_snap = format!("{}/installsnap.sh", dir.to_str().unwrap());
    run_cmd(&install_snap, "failed to install snapd");

    sp = Spinner::new(&Spinners::Dots9, "Installing VSCode".into());

    run_cmd("snap install code --classic", "failed to install vscode");

    sp.stop();

    sp = Spinner::new(&Spinners::Dots9, "Installing AUR Programs".into());

    let yay_cmd =
        "yay -S --removemake --nodiffmenu --noupgrademenu --noeditmenu --nodiffaur --noupgradear";

    let install_yay_cmd = format!(
        "echo {} | sudo --stdin {} {}",
        passwd, yay_cmd, "spotify spicetify-cli google-chrome"
    );

    run_cmd(&install_yay_cmd, "failed to install yay programs");

    sp.stop();

    println!("Finished!");
}
