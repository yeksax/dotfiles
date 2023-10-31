#! /bin/bash

BASE_DIR=$PWD

# sets pacman.conf to improve downloads (parallel downloads and color)
sudo cp ./pacman.conf /etc/pacman.conf

# installs packages, a lot of them
sudo pacman -Syyu --noconfirm --needed git base-devel neovim zsh feh chromium dconf xorg lightdm lightdm-gtk-greeter i3-wm i3lock picom nodejs npm unzip neofetch scrot alsa-utils rofi github-cli noto-fonts noto-fonts-emoji noto-fonts-extra light bc jq vlc xautomation vlc playerctl pwgen ttf-font-awesome polybar ffmpeg ffmpegthumbnailer p7zip materia-gtk-theme papirus-icon-theme lxappearance

# installs yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm
yay -Y --gendb
cd $BASE_DIR

# installs gnome terminal (with transparency) and rofi-greenclip
yay -S --noprovides --answerclean All --answerdiff None --mflags "--noconfirm --needed --clean" rofi-greenclip gnome-terminal-transparency zscroll-git

# installs packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim.git
~/.local/share/nvim/site/pack/packer/start/packer.nvim

# enables lightdm
sudo systemctl enable lightdm.service

# create some base directories
cd ~
mkdir -p videos documents pictures downloads .fonts .config

rm -rf .zshrc

cd ~/.config
rm -rf yay

# symlinks configs, wallpapers, configs, fonts and etc
cd $BASE_DIR
ln -sf $(pwd)/.config/* ~/.config/
ln -sf $(pwd)/home/* ~/

# sets zsh as default
sudo chsh $USER -s $(which zsh)

# for screen brightness control
sudo chmod +s $(which light)

echo ""
echo ""
echo ""
echo "Tudo pronto :)"
read -s -n 1 -p "Aperte qualquer tecla para entrar em seu i3 novinho"

# bye bye :)
sudo systemctl start lightdm.service
