#! /bin/bash

BASE_DIR=$PWD

# remove original files and link
sudo rm -f /etc/pacman.conf
sudo rm -f /etc/systemd/logind.conf

sudo ln -s $(pwd)/system/pacman.conf /etc/pacman.conf
sudo ln -s $(pwd)/system/logind.conf /etc/systemd/logind.conf

# installs packages, a lot of them
sudo pacman -Syyu --noconfirm --needed git base-devel tldr wget neovim vim zsh feh dconf xorg lightdm lightdm-gtk-greeter i3-wm i3lock picom nodejs npm unzip neofetch scrot alsa-utils rofi noto-fonts noto-fonts-emoji noto-fonts-extra light bc jq vlc xautomation playerctl ttf-font-awesome polybar ffmpeg ffmpegthumbnailer p7zip kitty xclip dunst zoxide bat

# installs yay
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm --clean
cd $BASE_DIR

# installing zscroll-git
git clone https://aur.archlinux.org/zscroll-git.git
cd zscroll-git
makepkg -si --noconfirm --clean
cd $BASE_DIR

# installing greenclip
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
chmod +x greenclip
sudo mv greenclip /usr/bin

# installing bun
curl -fsSL https://bun.sh/install | bash

# installs packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# enables lightdm
sudo systemctl enable lightdm.service

# create some base directories
cd ~
mkdir -p drive .config

cd drive
mkdir -p videos documents pictures downloads
ln -s * .* ~

# deletes conflicting directories/files
cd ~
rm -rf .fonts .zsh .zshrc .profile .gitconfig ascii scripts themes wallpapers

# deletes conflicting directories
cd ~/.config
rm -rf btop dconf dunst gtk-3.0 i3 nvim picom polybar rofi kitty yay greenclip.toml

# sets zsh as default
sudo chsh $USER -s $(which zsh)

# symlinks configs, wallpapers, configs, fonts and etc
cd $BASE_DIR
ln -s $(pwd)/config/* $(pwd)/config/.* ~/.config/
ln -s $(pwd)/home/* $(pwd)/home/.* ~/
ln -s $(pwd)/home/themes/mc /home/$USER/.local/share/mc/skins

# for screen brightness control
sudo chmod +s $(which light)

# cleaning residuals
rm -rf yay-bin
rm -rf zscroll-git

# bye bye :)
sudo systemctl start lightdm.service
