#!/bin/bash
preInstall () {
    sudo pacman -Syyu
    sudo pacman reflector git
    reflector -c Switzerland --sort rate -a 6 --save /etc/pacman.d/mirrorlist
}
yayInstall () {
    cd /opt
    sudo git clone https://aur.archlinux.org/yay-git.git
    sudo chown -R dawn:dawn ./yay-git
    cd yay-git
    makepkg -si
    yay -Syyu
}
pacInstall () {
    yay -S $(cat pacman.txt)
}
changeBootscreen () {
    cd boot/CyberRe
    ./install.sh
}
changeGreeter () {
    sudo systemctl disable sddm
    sudo systemctl enable light-dm
}
configInstall () {

}
run () {
    preInstall
    yayInstall
    pacInstall
    changeBootscreen
    changeGreeter
}
