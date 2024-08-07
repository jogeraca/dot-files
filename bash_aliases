#!/bin/bash

# ========= NETWORK FNs =========== #
function gipv4() {
	curl https://ipecho.net/plain
	echo
}
function gipv6() {
	curl https://ipecho.io/plain
	echo
}
echo -e "\e[3m Setting alias \e[23m \n"

#

so="$(uname -s)"
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

# ========= pacman =========== #
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

# alias update-nvim-nightly='asdf uninstall neovim nightly && asdf install neovim nightly'
# alias update-nvim-stable='asdf uninstall neovim stable && asdf install neovim stable'

## ============= GIT ============== #
function gstbk() { git stash store -m "$1" "$(git stash create)"; }
alias grhard='git reset --hard origin/$(git branch --show-current)'
alias grsoft='git reset --soft HEAD~1'
alias gg10='gg --max-count=10'
alias gtccb='git branch --show-current | xclip -i -selection clipboard'

alias grpo-dry="git remote prune origin --dry-run"
alias grpo-done="git remote prune origin"

function git_last_commits() {
	commit="$1"

	$(git log --reverse --abbrev-commit --pretty=format:\"%s\" $commit^..)
}

alias Glogc="git log --reverse --abbrev-commit  --pretty=format:\"%h - %s\" $1^.."

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

## =========== JSON - Sort clipboard json ========= #
alias json_sort='wl-paste | jq -Sr | wl-copy'

## =========== JSON - Sort clipboard json ========= #

function _mono.remote() {
	container=$(kubectl get pods --context=$1 --namespace=$2 -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}' | fzf)
	echo -e "\e[0;32m | $1 - $2 - $container -- remote console |\n\n"
	tput sgr0 # reset color
	kubectl --context=$1 --namespace=$2 exec -i -t $container -- bin/mono_banking remote
}
alias mono.remote.prod='_mono.remote mono-prod-eks-new mono-banking'
alias mono.remote.sandbox='_mono.remote mono-banking-sandbox mono-banking'

alias mono.db.forward.cert_priv='kubectl --context=$mono_cert --namespace=mono-banking port-forward svc/port-forwarding-service 5433:5432'
# alias mono.db.forward.prod_priv='kubectl --context=mono-prod-eks-new --namespace=mono-banking port-forward svc/port-forwarding-service 54545:5432'
alias mono.db.forward.prod_priv='kubectl --context=$mono_prod --namespace=mono-banking port-forward svc/port-forwarding-service 54545:5432'
alias mono.db.forward.replica_priv='kubectl --context=mono-prod-eks-new --namespace=mono-banking port-forward svc/port-forwarding-service 54546:5433'
alias mono.db.forward.sandbox_priv='kubectl --context=$mono_sdbx --namespace mono-banking port-forward svc/port-forwarding-service 54540:5432'

alias mono.deploy.logs.cert='kubectl --context=mono-banking-cert --namespace=mono-banking logs -f deployments/mono-banking-deployment'
alias mono.deploy.logs.prod='kubectl --context=$mono_prod --namespace=mono-banking logs -f deployments/mono-banking-deployment'
alias mono.deploy.logs.sandbox='kubectl --context=$mono_sdbx --namespace mono-banking logs -f deployments/mono-banking-deployment'

alias mono.panda.prod='kubectl --context=$mono_prod --namespace=mono-services port-forward svc/redpanda-console 38091:8080'
alias mono.panda.cert='kubectl --context=$mono_cert --namespace=mono-services port-forward svc/redpanda-console 38091:8080'

function git_diff_by_file() {
	commits="$1"
	origin_branch="$2"
	last_branch="$3"

	files=$(git log -n $commits --name-only --pretty=format: | sort -ur)

	for file in $files; do
		$(git diff $last_branch $origin_branch -- $file)
	done
}

alias crow-es='crow -tes'

alias firefox='MOZ_ENABLE_WAYLAND=1 firefox --no-remote'
