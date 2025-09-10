#!/bin/bash

./scripts/update-mirrors --latest 30 --fastest 10 --verbose -o /etc/pacman.d/mirrorlist
