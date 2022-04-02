mod consts;
mod repo;
mod user;

#[macro_use]
mod macros;

use colored::Colorize;
use consts::get_environment;

fn main() {
    let dev = get_environment().dev;
    if dev {
        println!("Running in dev mode");
    }

    let sp = create_spinner!("Cloning dotfiles repo...");

    match repo::clone_repo() {
        Ok(v) => v,
        Err(e) => {
            sp.stop_with_symbol(&"X".red());
            println!("\n{:?}", e);
            return;
        }
    };

    sp.stop_with_message("Finished cloning repo\n".into());

    if dev {
        use user::dotfiles_dir;
        let dir = dotfiles_dir().unwrap();
        std::fs::remove_dir_all(dir).unwrap();
    }
}
