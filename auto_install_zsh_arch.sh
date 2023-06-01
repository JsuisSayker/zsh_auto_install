#!/bin/bash

echo "Install zsh"
sudo pacman -Syyu zsh -y

zsh < 1

echo "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y

echo "Install zsh-autosuggestions"
cd $ZSH_CUSTOM/plugins
echo "Install zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Install zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Install ttf-font-awesome"
sudo pacman -Syyu ttf-font-awesome -y

echo "Install powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

cd ~/
file=".zshrc"
plugin_to_insert=" zsh-autosuggestions zsh-syntax-highlighting"
theme_to_insert="powerlevel10k/powerlevel10k"


# Read the file content into an array
mapfile -t lines < "$file"

# Insert the string at the specified line and column
line="${lines[80 - 1]}"
line="${line:0:13}${plugin_to_insert}${line:13}"
lines[80 - 1]="$line"

line="${lines[18 - 1]}"
line="${line:0:12}${theme_to_insert}${line:12}"
lines[18 - 1]="$line"
