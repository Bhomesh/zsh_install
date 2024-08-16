# this is the full installation guide for zsh with OMZ, Powerlevel10k, Plugins > autocomplete, fonts > 

# installation of zsh

echo "Starting system update..."


echo "Updating package list..."
sudo apt-get update

read -p "Do you want to install zsh? (y/n): " INSTALL_ZSH

if [ "$INSTALL_ZSH" = "y" ] || [ "$INSTALL_ZSH" = "Y" ]; then
  # Install zsh if the user agreed
  echo "Installing zsh..."
  sudo apt-get install zsh -y
  
  # Optionally, make zsh the default shell
  read -p "Do you want to make zsh your default shell? (y/n): " MAKE_DEFAULT_SHELL
  if [ "$MAKE_DEFAULT_SHELL" = "y" ] || [ "$MAKE_DEFAULT_SHELL" = "Y" ]; then
    echo "Changing default shell to zsh..."
    chsh -s $(which zsh)
    echo "Please log out and log back in to apply the new default shell."
  fi
else
  echo "Skipping zsh installation."
fi

read -P "Do you want to install Oh My Zsh? (y/n): " INSTALL_OMZ
if [ "$INSTALL_OMZ" = "y" ] || [ "$INSTALL_OMZ" = "Y" ]; then
    echo "installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "installation done"
else
  echo "Skipping Oh My Zsh installation."
fi

read -p "Optional options want to install (y/n)" INSTALL_OPTIONAL
if [ "$INSTALL_OPTIONAL" = "y" ] || [ "$INSTALL_OPTIONAL" = "Y" ]; then

    read -P "Do you want to install Powerlevel10k? (y/n): " INSTALL_PL10K
    if [ "$INSTALL_PL10K" = "y" ] || [ "$INSTALL_PL10K" = "Y" ]; then
        echo "installing Powerlevel10k..."
        git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
        echo "Set Powerlevel10k as the default theme in .zshrc"
        sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

        echo "Downloading and installing MesloLGS NF font..."
        wget -O "$HOME/Downloads/MesloLGS_NF_Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
        mkdir -p ~/.local/share/fonts
        mv "$HOME/Downloads/MesloLGS_NF_Regular.ttf" ~/.local/share/fonts/
        fc-cache -f -v
    else
        echo "Skipping Oh My Zsh installation."
    fi

    read -P "Do you want to install Syntax Highlighting (y/n): " INSTALL_SYNH
    if [ "$INSTALL_SYNH" = "y" ] || [ "$INSTALL_SYNH" = "Y" ]; then
        echo "Installing zsh-syntax-highlighting plugin..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

        # Add the plugin to the list in .zshrc
        sed -i 's/plugins=(/plugins=(zsh-syntax-highlighting /' ~/.zshrc
    else
        echo "Skipping Syntax Highlighting installation."
    fi

    read -P "Do you want to install Autosuggestions (y/n): " INSTALL_AS
    if [ "$INSTALL_AS" = "y" ] || [ "$INSTALL_AS" = "Y" ]; then
        # Install zsh-autosuggestions plugin
        echo "Installing zsh-autosuggestions plugin..."
        git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

        # Add the plugins to the list in .zshrc
        echo "Updating .zshrc with plugins..."
        sed -i 's/plugins=(/plugins=(zsh-syntax-highlighting zsh-autosuggestions /' ~/.zshrc

 
    else
        echo "Skipping Autosuggestions installation."
    fi


else
  echo "Skipping Optional installation."
fi