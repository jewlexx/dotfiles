pub fn get_password() -> Option<String> {
    match rpassword::read_password_from_tty(Some("Please enter the admin password: ")) {
        Ok(p) => {
            if p.is_empty() {
                println!("Password cannot be empty");
                None
            } else {
                Some(p)
            }
        }
        Err(e) => {
            panic!("Error: {:?}", e.to_string());
        }
    }
}
