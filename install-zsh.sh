#!/bin/bash

# Notify user of the start of the system update process
echo "Starting system update..."

# Update the package list
echo "Updating package list..."
sudo apt-get update

# Prompt the user to install zsh
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

# Prompt the user to install Oh My Zsh
read -p "Do you want to install Oh My Zsh? (y/n): " INSTALL_OMZ
if [ "$INSTALL_OMZ" = "y" ] || [ "$INSTALL_OMZ" = "Y" ]; then
    echo "Installing Oh My Zsh..."
     -c "$(shcurl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo "Installation done."
else
  echo "Skipping Oh My Zsh installation."
fi

# Prompt the user to install optional components
read -p "Do you want to install optional components? (y/n): " INSTALL_OPTIONAL
if [ "$INSTALL_OPTIONAL" = "y" ] || [ "$INSTALL_OPTIONAL" = "Y" ]; then

    # Prompt to install Powerlevel10k
    read -p "Do you want to install Powerlevel10k? (y/n): " INSTALL_PL10K
    if [ "$INSTALL_PL10K" = "y" ] || [ "$INSTALL_PL10K" = "Y" ]; then
        echo "Installing Powerlevel10k..."
        # Clone Powerlevel10k repository to Oh My Zsh themes directory
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
        echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
        echo "Setting Powerlevel10k as the default theme in .zshrc..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
        # Update .zshrc to use Powerlevel10k theme
        sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
        exec zsh 

        echo "Downloading and installing MesloLGS NF font..."
        # Download and install the MesloLGS NF font
        wget -O "$HOME/Downloads/MesloLGS_NF_Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
        mkdir -p ~/.local/share/fonts
        mv "$HOME/Downloads/MesloLGS_NF_Regular.ttf" ~/.local/share/fonts/
        fc-cache -f -v
    else
        echo "Skipping Powerlevel10k installation."
    fi

    # Prompt to install zsh-syntax-highlighting plugin
    read -p "Do you want to install Syntax Highlighting? (y/n): " INSTALL_SYNH
    if [ "$INSTALL_SYNH" = "y" ] || [ "$INSTALL_SYNH" = "Y" ]; then
        echo "Installing zsh-syntax-highlighting plugin..."
        # Clone zsh-syntax-highlighting repository to Oh My Zsh plugins directory
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        # Add the plugin to the list in .zshrc
        sed -i 's/plugins=(/plugins=(zsh-syntax-highlighting /' ~/.zshrc
    else
        echo "Skipping Syntax Highlighting installation."
    fi

    # Prompt to install zsh-autosuggestions plugin
    read -p "Do you want to install Autosuggestions? (y/n): " INSTALL_AS
    if [ "$INSTALL_AS" = "y" ] || [ "$INSTALL_AS" = "Y" ]; then
        echo "Installing zsh-autosuggestions plugin..."
        # Clone zsh-autosuggestions repository to Oh My Zsh plugins directory
        git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        # Add the plugins to the list in .zshrc
        echo "Updating .zshrc with plugins..."
        sed -i 's/plugins=(/plugins=(zsh-syntax-highlighting zsh-autosuggestions /' ~/.zshrc
    else
        echo "Skipping Autosuggestions installation."
    fi

else
  echo "Skipping optional components installation."
fi

echo "Installation script completed."
