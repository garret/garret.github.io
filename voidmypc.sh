#!/bin/bash
# https://github.com/garret
# Void Linux post-install script

bypass() {
  sudo -v
  while true;
  do
    sudo -n true
    sleep 45
    kill -0 "$$" || exit
  done 2>/dev/null &
}

echo "Starting Void Linux post-install script..." | tee -a "$HOME/voidmypc.log"
sleep 3s
	bypass

echo "Updating system..." | tee -a "$HOME/voidmypc.log"
sleep 3s
	cd $HOME
	sudo xbps-install -Syu | tee -a "$HOME/voidmypc.log"

echo "Installing packages..."
sleep 3s
	sudo xbps-install -Syf xorg-minimal xorg-fonts setxkbmap xkill xf86-video-intel wifish dialog dbus alsa-utils bash-completion curl psmisc htop bspwm sxhkd lxappearance micro leafpad firefox chromium rofi rofi-calc mpv dosfstools exfat-utils ntfs-3g gparted wget polybar neovim gvfs alacritty dunst zathura zathura-pdf-mupdf weechat ranger arandr git redshift Adapta arc-theme arc-icon-theme faba-icon-theme paper-icon-theme libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-i18n-en-US libreoffice-i18n-it libreoffice-i18n-da libreoffice-gnome gimp inkscape pipes.c gomatrix asciiquarium pfetch flameshot terminus-font calc numlockx ntp gotop clipit rofi-emoji xclip xsel noto-fonts-emoji xsetroot font-cozette font-tamzen font-tamsyn cherry-font termsyn-font font-Siji atool ueberzug tree cups-pdf freefont-ttf sxiv i3lock-color scrot ImageMagick xautolock pulseaudio tlp nodm pulsemixer xf86-input-synaptics xbacklight thunar-archive-plugin xarchiver fzf baobab bluez ttf-material-icons tdrop jq fontmanager VeraCrypt volnoti ncdu inxi gsimplecal-gtk3 fish-shell picard nicotine+ font-awesome5 base-devel libX11-devel libXft-devel libXinerama-devel freetype-devel fontconfig-devel harfbuzz-devel | tee -a "$HOME/voidmypc.log"

echo "Configuring system..." | tee -a "$HOME/voidmypc.log"
sleep 3s
	
	# Skip login in tty1
	sudo sed -i "s/--noclear/--noclear\ --skip-login\ --login-options=$USER/g" /etc/sv/agetty-tty1/conf | tee -a "$HOME/voidmypc.log"
	# Remove tty from 4 to 6
	sudo rm -f /var/service/agetty-tty{4,5,6} | tee -a "$HOME/voidmypc.log"
	
	# Services
	sudo ln -s /etc/sv/dbus /var/service/ | tee -a "$HOME/voidmypc.log"
	sudo ln -s /etc/sv/isc-ntpd /var/service/ | tee -a "$HOME/voidmypc.log"
	sudo ln -s /etc/sv/tlp /var/service/ | tee -a "$HOME/voidmypc.log"
	sudo ln -s /etc/sv/wpa_supplicant /var/service/ | tee -a "$HOME/voidmypc.log"
	sudo ln -s /etc/sv/bluetoothd /var/service/ | tee -a "$HOME/voidmypc.log"
	
	# Same GTK theme for root applications
	sudo ln -s $HOME/.gtkrc-2.0 /etc/gtk-2.0/gtkrc | tee -a "$HOME/voidmypc.log"
	sudo ln -s $HOME/.config/gtk-3.0/settings.ini /etc/gtk-3.0/settings.ini | tee -a "$HOME/voidmypc.log"
	
	# Logo-ls
	wget https://github.com/Yash-Handa/logo-ls/releases/download/v1.3.6/logo-ls_Linux_x86_64.tar.gz | tee -a "$HOME/voidmypc.log"
	tar -xzf logo-ls_Linux_x86_64.tar.gz | tee -a "$HOME/voidmypc.log"
	cd logo-ls_Linux_x86_64 | tee -a "$HOME/voidmypc.log"
	sudo cp logo-ls /usr/local/bin | tee -a "$HOME/voidmypc.log"
	cd $HOME | tee -a "$HOME/voidmypc.log"
	rm logo-ls_Linux_x86_64.tar.gz && rm -r logo-ls_Linux_x86_64 | tee -a "$HOME/voidmypc.log"

echo "Adding user to some groups..." | tee -a "$HOME/voidmypc.log"
sleep 3s
	sudo usermod -aG bluetooth $USER | tee -a "$HOME/voidmypc.log"

echo "Done! Please reboot." | tee -a "$HOME/voidmypc.log"
