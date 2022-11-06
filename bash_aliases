#!/bin/bash

echo -e "\e[3m Setting alias \e[23m \n"

#

so="$(uname -s)"
alias vim='nvim'
alias tmux='tmux -2'
alias vi='nvim'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ag='ag --color --group'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    alias d="fd"
    alias c="/usr/bin/cat"
    alias cat="/usr/bin/cat"
    alias grep="/usr/bin/grep --color=auto"
    alias g="/usr/bin/grep --color=auto"
    alias gh="/usr/bin/grep --color=auto --context=4"
else
    alias cat="bat"
    alias grep="rg"
    #alias g="rg"
    #alias gh="rg --context=4"
    #alias reboot="loginctl reboot"
    #alias xx="loginctl reboot"
fi

alias k=kubectl

# sincroniza con los repositorios remotos actualiza el sistema y luego instal el paquete en question
alias pins="sudo pacman -Syyu"

# sincroniza con los repositorios remotos y actualiza el sistema
alias pupdate="sudo pacman -Syyu"

#elimina un paquete y sus dependencias si no estan en uso por otro paquete
alias prm="sudo pacman -Rs"

#Elimina un paquete y sus dependencias (si es que no estan en uso por otro paquete) tombien el fichero de configuracion
alias pprune="sudo pacman -Rsn"

#Busca un paquete en los repositorios remotos
alias psearch="pacman -Ss"

#Busca informacion detallada sobre un paquete en un repositorio remoto
alias psearch="pacman -Si"

#Muestra informacion detallatda sobre un paquete en los repositorios locales
alias pinfo="pacman -Qi"

#Muestra todos los archivos y directorios que fueron creados para este paquete
alias pinspect="pacman -Ql"

#Muestra todos los paquetes instalados actualmente incluyendo sus dependencias
alias pshow="pacman -Q"

#Hiddem al anterior pero lista solamentes paquetes sin sus dependencias
alias pShow="pacman -Qe"

#muestra toda la lista de paquetes qeue no pertenecen a los repositorios oficiales
alias pShow="pacman -Qm"

alias update-nvim-nightly='asdf uninstall neovim nightly && asdf install neovim nightly'
alias update-nvim-stable='asdf uninstall neovim stable && asdf install neovim stable'

##git commands

alias grpo-dry="git remote prune origin --dry-run"
alias grpo-done="git remote prune origin"

# exa cammands
alias e="exa --icons --group-directories-first -F"
alias el="exa --icons --group-directories-first --git --color-scale -F -h -l -a"
alias ea="exa --icons --group-directories-first --git --color-scale -F -h -l -a"
alias et="exa --icons --group-directories-first -F --tree -L 3"
alias etl="exa --icons --group-directories-first --git --color-scale -F --tree -L 3 -h -l -a"
alias elt="exa --icons --group-directories-first --git --color-scale -F --tree -L 3 -h -l -a"
alias ec="exa --icons --group-directories-first -F -s time -r"
alias ecl="exa --icons --group-directories-first --git --color-scale -F -h -l -a -s time -r"
alias eca="exa --icons --group-directories-first --git --color-scale -F -h -l -a -s time -r"
alias ect="exa --icons --group-directories-first -F --tree -L -3 -s time -r"
alias eclt="exa --icons --group-directories-first --git --color-scale -F -h -l -a --tree -L 3 -s time -r"
alias etlc="exa --icons --group-directories-first --git --color-scale -F -h -l -a --tree -L 3 -s time -r"
