#!/usr/bin/bash

if [ "$1" ]; then
  source="$1"
else
  source=$HOME/src/
fi

a=$(echo $source/$(exa --icons --git --only-dirs --oneline $source | fzf --prompt="Donde vamos...? |> "  | cut -f2 -d' '))

cd $(echo $a)
