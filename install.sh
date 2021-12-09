#!bin/bash

install_zsh(){
 echo "Starting the installation oh my zsh"
 sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_zsh
