mod consts;
mod repo;
mod user;

#[macro_use]
mod macros;

use colored::Colorize;
use consts::get_environment;
use repo::ErrorMsg;

fn main() {
    let dev = get_environment().dev;
    if dev {
        println!("Running in dev mode");
    }

    let sp = create_spinner!("Cloning dotfiles repo...");

    match repo::clone_repo() {
        Ok(v) => v,
        Err(e) => {
            let msg = format!(
                "{}\n -> {:?}\n",
                "There was an error cloning the repo".red(),
                e.msg()
            );
            sp.stop_with_message(msg);
            return;
        }
    };

    sp.stop_with_message("Finished cloning repo\n".into());

    // if dev {
    //     use user::dotfiles_dir;
    //     let dir = dotfiles_dir().unwrap();
    //     std::fs::remove_dir_all(dir).unwrap();
    // }
}
