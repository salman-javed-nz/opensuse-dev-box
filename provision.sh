#!/usr/bin/env bash
set -eux -o pipefail

# Resize root partition (`/dev/sda1`) to take up all the free space in the disk.
zypper install --no-confirm e2fsprogs
printf "resizepart\n1\nYes\n100%%\nquit" | parted /dev/sda ---pretend-input-tty
resize2fs /dev/sda1

# Install basic KDE desktop.
zypper install --type pattern --no-confirm kde yast2_desktop kde_yast
zypper install --type pattern --no-confirm --recommends fonts
zypper install --no-confirm ark discover dolphin gwenview5 kate kcalc \
	kcolorchooser kdegraphics-thumbnailers kio-extras5 konsole MozillaFirefox \
	okular open-vm-tools-desktop plasma5-systemmonitor sddm
systemctl set-default graphical.target

# Install Git.
zypper install --no-confirm git git-lfs
git config --global core.editor nano

# Install Docker.
zypper install --no-confirm docker docker-compose docker-compose-switch
systemctl enable docker
usermod --groups docker --append vagrant

# Install Visual Studio Code.
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
zypper install --no-confirm code

# Install GitHub Desktop.
rpm --import https://rpm.packages.shiftkey.dev/gpg.key
zypper addrepo https://rpm.packages.shiftkey.dev/rpm shiftkey
zypper install --no-confirm github-desktop

# Unmount Vagrant provisioning files.
cd /
umount /vagrant
sed --in-place '/#VAGRANT-BEGIN/,/#VAGRANT-END/d' /etc/fstab
