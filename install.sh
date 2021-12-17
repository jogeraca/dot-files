
# guide to install https://gist.github.com/linderd/71ec30048e78813115ba3f634e1b0817
TARGET=~/dot-files
OPT_PATH=/opt
install_zsh(){
  echo "Starting the installation oh my zsh"
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
 git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
 git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
 sed -i "\$a source $1/ext_zshrc" ~/.zshrc
}
install_zsh $TARGET
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
dvp-it_ins(){
  ln -s ${TARGET}/dot-files/dvp-it/dvp-it /usr/share/X11/xkb/symbols/.
}

install_python(){
  pyenv install 3.9.9
  git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
  pyenv virtualenv 3.9.9 neovim3
  pyenv activate neovim3
  pyenv install 2.7.18 
  pyenv activate neovim2
  pyenv virtualenv 2.7.18 neovim2
  python -m pip install --user --upgrade pynvim
}

install_wifi(){
  yay -S linux5.15.10.arch1-1-headers-bin
  git clone https://github.com/lwfinger/rtw89.git
  cd rtw89
  make
  sudo make install
  sudo modprobe rtw89pci
  sudo rfkill unblock all
  sudo ip link set wlp3s0 up
}
#install_asdf 
build_git(){
  ln -s ~/dot-files/git/gitignore_general .gitignore
}

build_src(){
  mkdir ~/scr
}
build_sound(){
 # sudo modprobe snd_seq_oss snd_pcm_oss snd_mixer_oss
  #sudo alsactl init
  sed -i 's/load-module module-suspend-on-idle/#load-module module-suspend-on-idle/' /etc/pulse/default.pa
}

build_docker(){
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo groupadd docker
  newgrp docker
  sudo chown root:docker /var/run/docker.sock
  sudo usermod -aG docker yoser
  docker pull postgres:alpine
#  docker run -d -p 5432:5432 --name psqlcont-liftit-local-tms -e POSTGRES_PASSWORD=postgres -v $HOME/liftit/backup/LIFTIT_DB_TMS:/var/lib/postgresql/data postgis/postgis:11-3.0-alpine
  docker run -d -p 5432:5432 --name postgresql -e POSTGRES_PASSWORD=postgres
}

set_timedatectl(){
 timedatectl set-ntp true
}
