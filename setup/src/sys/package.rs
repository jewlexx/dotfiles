use std::fs::File;
use std::io::Write;
use std::process::{Command, ExitStatus};
use std::{fmt, fs};

use rand::distributions::Alphanumeric;
use rand::{thread_rng, Rng};
use which::which;

use crate::utils::fs::PROJECT_DIRS;

#[derive(Debug, Clone)]
pub enum PackageManager {
    Scoop(String),
    Pacman(String),
    Apt(String),
}

impl fmt::Display for PackageManager {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            PackageManager::Scoop(s) => write!(f, "{}", s),
            PackageManager::Pacman(s) => write!(f, "{}", s),
            PackageManager::Apt(s) => write!(f, "{}", s),
        }
    }
}

impl PackageManager {
    pub fn destructure(self) -> (PackageManager, String) {
        (self.clone(), self.to_string())
    }

    pub fn install(&self, package: &str) -> anyhow::Result<()> {
        match self {
            PackageManager::Scoop(s) => run_pwsh(format!("{} install {}", s, package)),
            PackageManager::Pacman(s) => {
                Command::new(s)
                    .arg("-S")
                    .arg(package)
                    .spawn()
                    .unwrap()
                    .wait_with_output()
                    .unwrap()
                    .status
            }
            PackageManager::Apt(s) => {
                Command::new(s)
                    .arg("install")
                    .arg(package)
                    .spawn()
                    .unwrap()
                    .wait_with_output()
                    .unwrap()
                    .status
            }
        };

        Ok(())
    }
}

fn random_string(n: usize) -> String {
    let mut rng = thread_rng();
    (0..n).map(|_| rng.sample(&Alphanumeric) as char).collect()
}

fn run_pwsh(cmd: String) -> ExitStatus {
    let cache_dir = PROJECT_DIRS.cache_dir();
    let logs_dir = cache_dir.join("logs");

    fs::create_dir_all(&logs_dir).expect("failed to create cache dir");

    let hash = random_string(10);
    let log_path = logs_dir.join(format!("{}.log", hash));
    let err_path = logs_dir.join(format!("{}.err", hash));

    let pwsh = which("pwsh").expect("pwsh not found");
    let child = cmd!(pwsh, "-Command", cmd)
        .stdout_path(log_path)
        .stderr_path(err_path)
        .run()
        .unwrap();

    child.status
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
            panic!("No supported package manager found");
        }
    } else {
        panic!("Unsupported OS!");
    }
}
