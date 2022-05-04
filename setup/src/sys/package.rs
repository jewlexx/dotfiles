use std::process::{Command, ExitStatus};

use which::which;

use crate::utils::fs::PROJECT_DIRS;

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

            let out_file = PROJECT_DIRS.cache_dir().join("scoop.install");
            let out_file_path = out_file.into_os_string().into_string().unwrap();

            run_pwsh(format!("iwr -useb get.scoop.sh > {}", out_file_path));
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
