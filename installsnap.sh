if ! [ $(command -v snap) ]; then
    echo "Installing snap"
    git clone https://aur.archlinux.org/snapd.git
    cd snapd
    makepkg -si

    sudo systemctl enable --now snapd.socket

    cd ..
    rm -rf snapd
fi