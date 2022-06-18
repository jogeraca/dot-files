#!/usr/bin/bash

source=$HOME/src/

work_path=$(echo $source$(exa --icons --git --only-dirs --oneline $source | fzf --prompt="Projecto...? |> "  | cut -f2 -d' '))


source sources.sh ${work_path}
