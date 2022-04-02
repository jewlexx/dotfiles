#[macro_export]
macro_rules! create_spinner {
    ($msg:expr) => {{
        use spinners::{Spinner, Spinners};

        let sp = Spinner::new(Spinners::Dots, $msg.into());

        sp
    }};
}
