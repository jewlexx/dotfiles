use lazy_static::lazy_static;

extern "C" {
    fn IsElevated() -> u8;
}

pub fn is_elevated() -> bool {
    unsafe {
        let res = IsElevated();

        res != 0
    }
}

lazy_static! {
    pub static ref IS_ELEVATED: bool = is_elevated();
}
