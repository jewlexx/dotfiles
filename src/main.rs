use git2::Repository;
use home::home_dir;
use reqwest::get;
use rpassword::read_password_from_tty;
use spinners::{Spinner, Spinners};
use std::{
    env,
    io::{stdout, Write},
    process::{Command, Output},
    thread::sleep,
    time::Duration,
};

async fn get_install_cmd(url: &str) -> String {
    let out = get(url).await.unwrap().text().await.unwrap();

    format!("\"{}\"", out)
}

async fn run_cmd(cmd: &str, err: &str) -> Output {
    Command::new("sh").arg("-c").arg(cmd).output().expect(err)
}

async fn get_pacman() -> Result<String, String> {
    let mut out = run_cmd("command -v pacman", "Something went wrong here").await;
    let mut pacman = "unknown";

    if out.stdout.len() != 0 {
        pacman = "pacman";
    } else {
        out = run_cmd("command -v apt", "Something went wrong here").await;
        if out.stdout.len() != 0 {
            pacman = "apt";
        }
    }

    Ok(pacman.to_string())
}

#[tokio::main]
async fn main() {
    let pacman = get_pacman().await.unwrap();

    if pacman == "unknown" {
        panic!("unsupported operating system!");
    }

    let url = "https://github.com/jamesinaxx/dotfiles.git";
    let home_dir = home_dir().unwrap();
    let mut clone_dir = home_dir.clone();

    let args: Vec<String> = env::args().collect();
    let passed_dir = args.get(1);
    if passed_dir.is_none() {
        clone_dir.push("dotfiles");
    } else {
        clone_dir.push(passed_dir.unwrap())
    }

    let passwd = read_password_from_tty(Some("Please enter the root password: ")).unwrap();
    println!("Thank you :)");

    let mut sp: Spinner;

    sp = Spinner::new(&Spinners::Dots, "Cloning dotfiles repository...".into());

    let dotfiles_repo = Repository::clone(url, &clone_dir);

    sp.stop();

    if dotfiles_repo.is_err() {
        println!("\n\nSomething went wrong cloning the repository");
        println!("Double check the directory isn't already in use\n");

        let mut out = stdout();

        // Cute lil countdown
        for i in (0..6).rev() {
            out.flush().expect("Could not flush stdout");
            sleep(Duration::from_secs(1));
            print!("\rContinuing in {}...", i);
        }
    }

    let installcmd = format!("echo {} | sudo --stdin pacman -Syu yay --noconfirm", passwd);

    let programs: Vec<&str> = [
        "base-devel",
        "zip",
        "unzip",
        "git",
        "curl",
        "zsh",
        "rust",
        "rust-bindgen",
        "rust-wasm",
        "cargo",
        "spotify",
        "spicetify-cli",
        "google-chrome",
        "snapd",
    ]
    .to_vec();

    let yay_cmd =
        "yay -S --removemake --nodiffmenu --noupgrademenu --noeditmenu --nodiffaur --noupgradear";

    for program in programs {
        let installing_msg = format!("Installing {}", program);
        sp = Spinner::new(&Spinners::Dots, installing_msg);
        let install_yay_cmd = format!("echo {} | sudo --stdin {} {}", passwd, yay_cmd, program);
        let error_msg = format!("failed to install {}", program);

        run_cmd(&install_yay_cmd, &error_msg).await;
        sp.stop();
    }

    run_cmd(&installcmd, "failed to upgrade system packages").await;

    let mut cmd = get_install_cmd("https://get.sdkman.io").await;

    run_cmd(&cmd, "failed to install sdkman").await;

    run_cmd("sdk install java 17.0.1-open", "failed to install java").await;

    run_cmd("sdk install gradle", "failed to install gradle").await;

    sp = Spinner::new(&Spinners::Dots, "Installing oh-my-zsh and friends".into());

    cmd = get_install_cmd(
        "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh",
    )
    .await;

    run_cmd(&cmd, "failed to install oh-my-zsh").await;

    let mut omz_dir = home_dir.clone();
    omz_dir.push(".oh-my-zsh");
    omz_dir.push("custom");
    omz_dir.push("themes");

    let mut _err = Repository::clone(
        "https://github.com/romkatv/powerlevel10k.git",
        format!("{}/powerlevel10k", omz_dir.to_str().unwrap()),
    )
    .err();

    omz_dir.push("plugins");

    _err = Repository::clone(
        "https://github.com/zsh-users/zsh-autosuggestions.git",
        format!("{}/zsh-autosuggestions", omz_dir.to_str().unwrap()),
    )
    .err();

    _err = Repository::clone(
        "https://github.com/zsh-users/zsh-syntax-highlighting.git",
        format!("{}/zsh-syntax-highlighting", omz_dir.to_str().unwrap()),
    )
    .err();

    sp.stop();

    sp = Spinner::new(&Spinners::Dots, "Installing NodeJS".into());

    cmd = get_install_cmd("https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh").await;

    run_cmd(&cmd, "failed to install nvm").await;

    run_cmd("nvm install --lts", "failed to install lts NodeJS").await;
    run_cmd("nvm install node", "failed to install latest NodeJS").await;
    run_cmd("nvm use --lts", "failed to set to use lts NodeJS").await;
    run_cmd("npm i -g yarn", "failed to install yarn globally").await;

    sp.stop();

    let ln_cmd = format!(
        "echo {} | sudo --stdin ln -s /var/lib/snapd/snap /snap",
        passwd
    );

    run_cmd(&ln_cmd, "failed to symlink for classic snaps").await;

    sp = Spinner::new(&Spinners::Dots, "Installing VSCode".into());

    run_cmd("snap install code --classic", "failed to install vscode").await;

    sp.stop();

    run_cmd(
        "rm $HOME/.zshrc $HOME/.gitconfig $HOME/.p10k.zsh -f",
        "failed to remove old config files",
    )
    .await;

    run_cmd("ln -s $HOME/dotfiles/zshrc $HOME/.zshrc && ln -s $HOME/dotfiles/p10k.zsh $HOME/.p10k.zsh && ln -s $HOME/dotfiles/gitconfig $HOME/.gitconfig", "failed to symlink config files").await;

    println!("\nFinished! Go have some fun :)");
}
