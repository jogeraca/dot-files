#!bin/bash
TARGET=~/dot-files
OPT_PATH=/opt
install_zsh(){
 echo "Starting the installation oh my zsh"
 sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
 sed -i "\$a source $1/ext_zshrc" ~/.zshrc
}
#install_zsh $TARGET
install_asdf(){
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
  asdf=~/.asdf/bin/asdf
  $asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  $asdf install nodejs latest
  $asdf global nodejs latest
  $asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  $asdf install elixir ref:a64d42f5d3cb6c32752af9d3312897e8cd5bb7ec
  $asdf global elixir ref:a64d42f5d3cb6c32752af9d3312897e8cd5bb7ec
  $asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
  $asdf install erlang 24.1.2
  $asdf global erlang 24.1.2
}
#install_asdf 

