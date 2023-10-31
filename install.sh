#! /bin/bash

BASE_DIR=$PWD

# sets pacman.conf to improve downloads (parallel downloads and color)
sudo cp ./pacman.conf /etc/pacman.conf

# installs packages, a lot of them
sudo pacman -S --noconfirm --needed git base-devel neovim zsh feh chromium dconf xorg lightdm lightdm-gtk-greeter i3-wm i3lock picom nodejs npm unzip neofetch scrot alsa-utils rofi github-cli noto-fonts noto-fonts-emoji noto-fonts-extra light bc jq vlc xautomation vlc playerctl pwgen ttf-font-awesome polybar ffmpeg ffmpegthumbnailer p7zip

# installs yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm
yay -Y --gendb
cd $BASE_DIR

# installs gnome terminal (with transparency) and rofi-greenclip
yay -S --noprovides --answerclean All --answerdiff None --mflags "--noconfirm --needed" rofi-greenclip gnome-terminal-transparency

# installs packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
~/.local/share/nvim/site/pack/packer/start/packer.nvim

# enables lightdm
sudo systemctl enable lightdm.service

# create some base directories
cd ~
mkdir themes videos documents pictures downloads

# symlinks configs, wallpapers, configs, fonts and etc
cd $BASE_DIR
ln -s ./wallpapers/* ~/wallpapers/
ln -s ./themes/* ~/themes/
ln -s ./.config/* ~/.config/
ln -s ./.fonts/* ~/.fonts

ln -s ./gitconfig ~/.gitconfig
ln -s ./zshrc ~/.zshrc

# sets zsh as default
sudo chsh $USER -s $(which zsh)

echo ""
echo ""
echo ""
echo "Tudo pronto :)"
read -s -n 1 -p "Aperte qualquer tecla para entrar em seu i3 novinho"

# bye bye :)
sudo systemctl start lightdm.service
