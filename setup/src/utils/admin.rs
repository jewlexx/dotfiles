use lazy_static::lazy_static;

extern "C" {
    fn IsElevated() -> u8;
}

pub fn is_elevated() -> bool {
    unsafe { IsElevated() != 0 }
}

lazy_static! {
    pub static ref IS_ELEVATED: bool = is_elevated();
}
