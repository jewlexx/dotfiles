use std::process::{Command, ExitStatus};

use rand::distributions::Alphanumeric;
use rand::{thread_rng, Rng};
use which::which;

use crate::utils::fs::PROJECT_DIRS;

pub enum PackageManager {
    Scoop(String),
    Pacman(String),
    Apt(String),
    Unsupported(String),
}

fn random_string(n: usize) -> String {
    let mut rng = thread_rng();
    (0..n).map(|_| rng.sample(&Alphanumeric) as char).collect()
}

fn run_pwsh(cmd: String) -> ExitStatus {
    let pwsh = which("pwsh").expect("pwsh not found");
    let mut child = Command::new(pwsh)
        .arg("-Command")
        .arg(cmd)
        .spawn()
        .expect("failed to execute process");

    let out = child.wait_with_output().expect("failed to wait on child");
    let stdout = out.stdout;

    let code = out.status;

    code
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
