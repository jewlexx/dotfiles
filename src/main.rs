use std::process::Command;

fn cmd_exists(cmd: &str) -> bool {
    Command::new(cmd).output().is_ok()
}

#[tokio::main]
async fn main() {
    if cmd_exists("git") {
        println!("You already have git installed");
    } else {
        println!("You do not have git installed");
    }
}
