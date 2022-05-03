use crate::utils::admin::IS_ELEVATED;
use anyhow::{anyhow, Result};

mod utils;

const GIT_URL: &str = "https://github.com/jewlexx/dotfiles.git";

fn main() -> Result<()> {
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

    Ok(())
}
