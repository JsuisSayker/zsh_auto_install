#!/bin/bash

echo
echo "-----------"
echo "Install zsh"
echo "-----------"
echo
sudo apt install zsh -y

echo
echo "-------------------------------"
echo "<C>D after seeing the zsh promt"
echo "-------------------------------"
echo
zsh < 1

echo
echo "-----------"
echo "Install curl"
echo "-----------"
echo
sudo apt install curl -y

echo
echo "-----------------"
echo "Install oh-my-zsh"
echo "-----------------"
echo
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y

echo
echo "----------------------------"
echo "Go to the zsh plugins folder"
echo "----------------------------"
echo
cd $ZSH_CUSTOM/plugins

echo
echo "---------------------------"
echo "Install zsh-autosuggestions"
echo "---------------------------"
echo
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo
echo "-------------------------------"
echo "Install zsh-syntax-highlighting"
echo "-------------------------------"
echo
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo
echo "------------------------"
echo "Install ttf-font-awesome"
echo "------------------------"
echo
sudo apt install fonts-font-awesome -y

echo
echo "---------------------"
echo "Install powerlevel10k"
echo "---------------------"
echo
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo
echo "-----------"
echo "open .zshrc"
echo "-----------"
echo
cd ~
file=".zshrc"

echo
echo "-----------------------------------"
echo "Read the file content into an array"
echo "-----------------------------------"
echo
mapfile -t lines < "$file"

echo
echo "------------------------"
echo "Insert the plugin string"
echo "------------------------"
echo
plugin_to_insert=" zsh-autosuggestions zsh-syntax-highlighting"
line="${lines[73 - 1]}"
line="${line:0:12}${plugin_to_insert}${line:12}"
lines[73 - 1]="$line"

echo
echo "-----------------------"
echo "Insert the theme string"
echo "-----------------------"
echo
theme_to_insert="powerlevel10k/powerlevel10k"
line="${lines[11 - 1]}"
line="${line:0:11}${theme_to_insert}${line:23}"
lines[11 - 1]="$line"

echo
echo "-------------------------------------------"
echo "Write the modified content back to the file"
echo "-------------------------------------------"
echo
printf "%s\n" "${lines[@]}" > "$file"

echo
echo "-------------------------------------"
echo "Shitch the default shell to ZSH shell"
echo "-------------------------------------"
echo
chsh -s /bin/zsh
