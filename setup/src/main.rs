use crate::utils::{admin::IS_ELEVATED, git::clone_repo};

#[macro_use]
extern crate anyhow;

#[macro_use]
extern crate lazy_static;

mod utils;

fn main() -> anyhow::Result<()> {
    #[cfg(target_os = "windows")]
    {
        if !*IS_ELEVATED {
            Err(anyhow!(
                "Because you are on Windows, you must run this as admin. Sorry ik it sucks :("
            ))
        } else {
            Ok(())
        }
    }?;

    println!("Started cloning repository...");
    let repo_task = clone_repo();

    Ok(())
}
