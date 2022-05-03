use lazy_static::lazy_static;

extern "C" {
    fn TestFunc() -> i32;
}

pub fn get_char() -> i32 {
    unsafe { TestFunc() }
}
