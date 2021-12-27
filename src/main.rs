use sys_info::linux_os_release;

fn main() {
    let release = linux_os_release().unwrap();
    let distro = release.id.unwrap();
    let pretty_name = release.name.unwrap();

    println!("Running on: {}", pretty_name);

    if distro != "manjaro" {
        panic!("Unsupported operating system!");
    }
}
