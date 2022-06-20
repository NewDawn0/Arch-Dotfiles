#!/bin/bash
this=$(pwd)
thisDir=$this
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
    cd $thisDir
}
pacInstall () {
    cd $thisDir
    yay -S $(cat pacman.txt)
}
changeBootscreen () {
    cd boot/CyberRe
    ./install.sh
    cd $thisDir
}
changeGreeter () {
    sudo systemctl disable sddm
    sudo systemctl enable light-dm
}
configInstall () {
    kwalletSettings () {
        cp other/kwalletrc ~/.config/
    }
    wallsInstall () {
        cp -R walls/* ~/Pictures
    }
    configFolderInstall () {
        cp -R .config/* ~/.config/
    }
    ndosInstall () {
        cp -R .ndos ~/
    }
    CustomScriptsInstall () {
        cp -R CustomScripts ~/
    }
    vconsoleInstall () {
        sudo cp other/vconsole.conf ~/etc/vconsole.conf
    }
    compileDmenu () {
        cd CustomScripts/dmenu-distrotube
        sudo make install
        cd $thisDir
    }
    compileST () {
        cd other
        makepkg -cf
        sudo pacman -U *.pkg.tar.zst
        cd $thisDir
    }
    binInstall () {
        sudo cp bin/* /usr/local/bin
    }
    wikiInstall () {
        cd ~
        mkdir git
        cd git
        git clone git@github.com:BetaPictoris/wiki.git      # Clone the repository
        cd wiki                                             # Change into the repository's directory
        make                                                # Build Wiki CLI
        sudo make install                                   # Install Wiki CLI to "/usr/local/bin" with the mode "755"
        cd $thisDir
    }
    superstonkInstall () {
        cd ~/git
        git clone https://github.com/bjarneo/superstonk.git
        cd superstonk
        go build
        sudo cp superstonk /usr/local/bin
        cd $thisDir
    }
    superstonkInstall
    wikiInstall
    binInstalli
    compileST
    compileDmenu
    vconsoleInstall
    CustomScriptsInstall
    ndosInstall
    configFolderInstall
    kwalletSettings
    wallsInstall
}
gitHubInstalls () {
    createInstall () {
        cd ~/GitHub
        git clone https://github.com/NewDawn0/create-templates.git
        cd create-templates
        sudo mv create /usr/local/bin/
        mkdir -p $HOME/.ndos/create/
        mv templates/* $HOME/.ndos/create/
        cd $thisDir
    }
    wordleSolverInstall () {
        cd ~/GitHub
        git clone https://github.com/NewDawn0/wordle-solver.git
        cd wordle-solver
        sudo cp words /usr/share/dict/
        sudo cp wordleSolver /usr/local/bin
        cd $thisDir
    }
    wordleSolverInstall
    createInstall
}
run () {
    preInstall
    yayInstall
    pacInstall
    configInstall
    gitHubInstalls
    changeBootscreen
    changeGreeter
}
