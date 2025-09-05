#!/bin/bash

ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

pacman -Syu
pacman -S sudo base-devel grub efibootmgr sddm linux-headers linux-api-headers linux-firmware-nvidia
pacman -S alacritty nano nano-syntax-highlighting vlc wofi noto-fonts swaync dolphin nmap ffmpeg man-db man-pages bash bash-completion amd-ucode reflector
pacman -S networkmanager firewalld flatpak dialog openssh openssl iwd wireplumber pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse
pacman -S --noconfirm nvidia nvidia-utils nvidia-settings 

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable firewalld

useradd -mG wheel verico
echo verico:password | chpasswd

# external
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
curl -s https://ohmyposh.dev/install.sh | bash -s
