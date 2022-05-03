use crate::utils::admin::get_char;

mod utils;

const GIT_URL: &str = "https://github.com/jewlexx/dotfiles.git";

fn main() {
    let c = get_char();

    println!("char: {}", c);
}
