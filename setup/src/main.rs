use crate::utils::admin::IS_ELEVATED;

mod utils;

const GIT_URL: &str = "https://github.com/jewlexx/dotfiles.git";

fn main() {
    let c = *IS_ELEVATED;

    println!("Elevated? {}", c);
}
