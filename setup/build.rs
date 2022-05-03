use std::fmt::format;

const PLATFORM: &str = {
    if cfg!(target_os = "windows") {
        "win"
    } else {
        "unix"
    }
};

fn main() {
    let file_path = format!("src/sys/{}.c", PLATFORM);

    cc::Build::new().file(file_path).compile("admin");
}
