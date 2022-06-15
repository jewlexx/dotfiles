import requests
import pygit2
import os
from operator import contains
from sys import argv

from temp import create_temp_file, temp_dir

cargo_pkgs = contains(argv, "--cargo-pkgs")


def install_yay():
    print("Installing yay...")
    yay_dir = temp_dir + "/yay"

    try:
        os.removedirs(yay_dir)
    except FileNotFoundError:
        pass

    pygit2.clone_repository("https://aur.archlinux.org/yay.git", yay_dir).free()

    os.system("cd " + yay_dir + " && makepkg -si")

    try:
        os.removedirs(yay_dir)
    except FileNotFoundError:
        pass


install_yay()
