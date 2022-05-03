use crate::utils::admin::IS_ELEVATED;
use anyhow::{anyhow, Result};

mod utils;

const GIT_URL: &str = "https://github.com/jewlexx/dotfiles.git";

fn main() -> Result<()> {
    #[cfg(target_os = "windows")]
    {
        if !*IS_ELEVATED {
            Err(anyhow!("Please run this program as administrator."))
        } else {
            Ok(())
        }
    }?;

    Ok(())
}
