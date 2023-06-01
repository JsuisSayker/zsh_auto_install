#!/bin/bash

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Create a function to insert the autosuggestion plugin in the .zshrc file
insert_plugin_in_zshrc() {
  cd ~/
  file=".zshrc"
  line_number=83
  column_number=13
  string_to_insert="$1"

  # Read the file content into an array
  mapfile -t lines < "$file"

  # Insert the string at the specified line and column
  line="${lines[$line_number - 1]}"
  line="${line:0:$column_number}${string_to_insert}${line:$column_number}"
  lines[$line_number - 1]="$line"

  # Write the modified content back to the file
  printf "%s\n" "${lines[@]}" > "$file"
}

# Create a function to ask the user if he want to add the highlighting plugin
syntax() {
  read -p "Would you want to install the syntax highlighting plugin? [Y/n] " answer
  if [ -z "$answer" ] || [ "$answer" = "y" ] || [ "$answer" = "Y" ] ||
  [ "$answer" = "yes" ] || [ "$answer" = "yEs" ] || [ "$answer" = "yeS" ] ||
  [ "$answer" = "yES" ] || [ "$answer" = "Yes" ] || [ "$answer" = "YEs" ] ||
  [ "$answer" = "YeS" ] || [ "$answer" = "YES" ]; then
    cd ~/.oh-my-zsh/custom/plugins
    git clone git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    insert_plugin_in_zshrc " zsh-syntax-highlighting"
  elif [ "$answer" = "no" ] || [ "$answer" = "No" ] || [ "$answer" = "nO" ] ||
  [ "$answer" = "NO" ] || [ "$answer" = "n" ] || [ "$answer" = "N" ];then
    exit 0
  else
    echo
    syntax
  fi
}

read -p "Would you want to install the autosuggestion plugin? [Y/n] " answer
if [ -z "$answer" ] || [ "$answer" = "y" ] || [ "$answer" = "Y" ] ||
[ "$answer" = "yes" ] || [ "$answer" = "yEs" ] || [ "$answer" = "yeS" ] ||
[ "$answer" = "yES" ] || [ "$answer" = "Yes" ] || [ "$answer" = "YEs" ] ||
[ "$answer" = "YeS" ] || [ "$answer" = "YES" ]; then
  cd ~/.oh-my-zsh/custom/plugins
  git clone git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  insert_plugin_in_zshrc " zsh-autosuggestions"
  syntax
elif [ "$answer" = "no" ] || [ "$answer" = "No" ] || [ "$answer" = "nO" ] ||
[ "$answer" = "NO" ] || [ "$answer" = "n" ] || [ "$answer" = "N" ];then
  echo
  syntax
else
  echo
  ./auto_install.sh
fi

