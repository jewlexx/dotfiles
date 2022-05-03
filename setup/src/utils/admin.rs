use lazy_static::lazy_static;

extern "C" {
    fn TestFunc() -> char;
}

pub fn get_char() -> char {
    unsafe { TestFunc() as char }
}
