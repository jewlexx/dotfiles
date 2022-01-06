[package]
name = "dotfiles"
version = "1.1.0"
edition = "2021"

# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html

[dependencies]
home = "0.5.3"
spinners = "2.0.0"
rpassword = "5.0.1"
git2 = "0.13.25"
reqwest = "0.11.8"
tokio = { version = "1", features = ["macros", "rt-multi-thread"] }