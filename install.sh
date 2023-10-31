#! /bin/bash

BASE_DIR=$PWD

# sets pacman.conf to improve downloads (parallel downloads and color)
sudo cp ./pacman.conf /etc/pacman.conf

# installs packages, a lot of them
sudo pacman -Syyu --noconfirm --needed git base-devel wget neovim vim zsh feh chromium dconf xorg lightdm lightdm-gtk-greeter i3-wm i3lock picom nodejs npm unzip neofetch scrot alsa-utils rofi github-cli noto-fonts noto-fonts-emoji noto-fonts-extra light bc jq vlc xautomation vlc playerctl pwgen ttf-font-awesome polybar ffmpeg ffmpegthumbnailer p7zip materia-gtk-theme papirus-icon-theme lxappearance

# installs yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm -clean
cd $BASE_DIR

# installing gnome-terminal-transparency
git clone https://aur.archlinux.org/gnome-terminal-transparency.git
cd gnome-terminal-transparency
makepkg -si --noconfirm -clean
cd $BASE_DIR

# installing zscroll-git
git clone https://aur.archlinux.org/zscroll-git.git
cd zscroll-git
makepkg -si --noconfirm -clean
cd $BASE_DIR

# installing greenclip
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
chmod +x greenclip
sudo mv greenclip /usr/bin

# installs packer.nvim
mkdir -p ~/.local/share/nvim/site/pack/packer/start
git clone --depth 1 https://github.com/wbthomason/packer.nvim.git
~/.local/share/nvim/site/pack/packer/start/packer.nvim

# enables lightdm
sudo systemctl enable lightdm.service

# create some base directories
cd ~
mkdir -p videos documents pictures downloads .fonts .config

# deletes conflicting directories
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
# sudo systemctl start lightdm.service
