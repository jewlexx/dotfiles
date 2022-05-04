use std::process::Command;

use which::which;

pub enum PackageManager {
    Scoop(String),
    Pacman(String),
    Apt(String),
    Unsupported(String),
}

pub fn get_pacman() -> PackageManager {
    if cfg!(target_os = "windows") {
        if let Ok(path) = which("scoop") {
            PackageManager::Scoop(path.to_string_lossy().into())
        } else {
            let pwsh = which("pwsh.exe").unwrap();
            let cmd = Command::new(pwsh).arg("-Command \"Set-ExecutionPolicy RemoteSigned -Scope CurrentUser && Invoke-WebRequest get.scoop.sh | Invoke-Expression\"").spawn().unwrap().wait().unwrap();
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
