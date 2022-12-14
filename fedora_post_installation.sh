#!bin/bash

#### This is a post installation script written for Fedora 36 by mpavan
#### it needs to be run as superuser

# configure DNF package manager
mv /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
cat << EOF > /etc/dnf/dnf.conf
[main]
gpgcheck=1
installonly_limit=3
clean_requirements_on_remove=True
best=False
skip_if_unavailable=True
fastestmirror=true
deltarpm=true
max_parallel_downloads=10
keepcache=True
defaultyes=True
EOF

# add RPM Fusion (both free and non-free
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# add Flathub repository for Flatpak applications
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# update the system
dnf update -y

# install some needed packages

## rpm packages
# microsoft fonts
dnf install curl cabextract xorg-x11-font-utils fontconfig -y
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm #variabilize version
# gnome-tweaks
dnf install gnome-tweaks -y
# gimp
dnf install gimp -y
# neofetch
dnf install neofetch -y
# megasync
wget https://mega.nz/linux/repo/Fedora_36/x86_64/megasync-4.6.8-2.1.x86_64.rpm #variabilize version
wget https://mega.nz/linux/repo/Fedora_36/x86_64/nautilus-megasync-3.6.6-2.1.x86_64.rpm #variabilize version
dnf install libmediainfo libzen -y
rpm -i megasync-4.6.8-2.1.x86_64.rpm
rpm -i nautilus-megasync-3.6.6-2.1.x86_64.rpm
rm megasync-4.6.8-2.1.x86_64.rpm nautilus-megasync-3.6.6-2.1.x86_64.rpm
# microsoft-edge
rpm --import https://packages.microsoft.com/keys/microsoft.asc
dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
dnf update --refresh
dnf install microsoft-edge-stable -y
# nomachine
wget https://download.nomachine.com/download/7.10/Linux/nomachine_7.10.1_1_x86_64.rpm #variabilize version
rpm -i nomachine_7.10.1_1_x86_64.rpm
rm nomachine_7.10.1_1_x86_64.rpm
# nordvpn
wget https://repo.nordvpn.com/yum/nordvpn/centos/noarch/Packages/n/nordvpn-release-1.0.0-1.noarch.rpm #variabilize version
rpm -i nordvpn-release-1.0.0-1.noarch.rpm
rm nordvpn-release-1.0.0-1.noarch.rpm
# rambox
wget https://github.com/ramboxapp/download/releases/download/v2.0.6/Rambox-2.0.6-linux-x64.rpm #variabilize version
rpm -i Rambox-2.0.6-linux-x64.rpm
rm Rambox-2.0.6-linux-x64.rpm
# visual studio code
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
dnf install code -y

## flatpak packages
# extension manager
flatpak install flathub com.mattjakeman.ExtensionManager -y
# mailspring
flatpak install flathub com.getmailspring.Mailspring -y
# onlyoffice
flatpak install flathub org.onlyoffice.desktopeditors -y
# spotify
flatpak install flathub com.spotify.Client -y


## MMS stuff
# parallel
dnf install parallel -y
# ffmpeg
dnf install ffmpeg -y
# gnuplot
dnf install gnuplot -y
# openbabel
dnf install openbabel -y
# conda (latest version)
version=$(wget https://repo.anaconda.com/archive/ -q -O- |\
   grep 'Anaconda3'|\
   sed -n 's|.*>Anaconda3-\([0-9]\{4\}\.[0-9]\{2\}\)-.*|\1|p' |\
   uniq |\
   sort -r |\
   head -1)
wget "https://repo.anaconda.com/archive/Anaconda3-$version-Linux-x86_64.sh"
bash Anaconda3-$version-Linux-x86_64.sh
rm Anaconda3-$version-Linux-x86_64.sh
#chimera
#plants
#vmd




