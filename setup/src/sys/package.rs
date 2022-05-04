use which::which;

pub enum PackageManager {
    Scoop(String),
    Pacman(String),
    Apt(String),
    Unsupported(String),
}

lazy_static! {
    pub static ref MANAGER: PackageManager = {
        if cfg!(target_os = "windows") {
            PackageManager::Scoop("".into())
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
    };
}
