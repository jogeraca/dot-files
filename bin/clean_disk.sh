echo "Remove unused packages"
sudo pacman -Qtdq

echo "Remove unused packages"
sudo pacman -Rs $(pacman -Qtdq)

echo "Clean the package cache"
yay -Scc
