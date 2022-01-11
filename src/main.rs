use std::process::Command;

fn cmd_exists(cmd: &str) -> bool {
    Command::new(cmd).output().is_ok()
}

#[tokio::main]
async fn main() {
    if !cmd_exists("apt") {
        panic!("apt is not available")
    }
}
