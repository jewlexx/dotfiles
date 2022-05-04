use std::process::{Command, ExitStatus};

use which::which;

pub enum PackageManager {
    Scoop(String),
    Pacman(String),
    Apt(String),
    Unsupported(String),
}

fn run_pwsh(cmd: String) -> ExitStatus {
    let pwsh = which("pwsh").expect("pwsh not found");
    let mut child = Command::new(pwsh)
        .arg("-Command")
        .arg(cmd)
        .spawn()
        .expect("failed to execute process");

    child.wait().expect("failed to wait on child")
}

pub fn get_pacman() -> PackageManager {
    if cfg!(target_os = "windows") {
        if let Ok(path) = which("scoop") {
            PackageManager::Scoop(path.to_string_lossy().into())
        } else {
            run_pwsh("Set-ExecutionPolicy RemoteSigned -Scope CurrentUser".into());
            run_pwsh("iwr -useb get.scoop.sh | iex".into());
            println!("Trying again... NOTE: THIS SHOULD NOT PRINT MORE THAN ONCE!");
            get_pacman()
        }
    } else if cfg!(target_os = "linux") {
        if let Ok(path) = which("pacman") {
            PackageManager::Pacman(path.to_string_lossy().into())
        } else if let Ok(path) = which("apt") {
            PackageManager::Apt(path.to_string_lossy().into())
        } else {
            PackageManager::Unsupported("No supported package manager found".into())
        }
    } else {
        PackageManager::Unsupported("Unsupported OS!".into())
    }
}
