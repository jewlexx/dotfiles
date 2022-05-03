fn main() {
    cc::Build::new().file("src/c/admin.c").compile("admin");
}
