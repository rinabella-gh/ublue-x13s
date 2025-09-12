#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

cp /ctx/jlinton-x13s.repo /etc/yum.repos.d/ # add communtiy repo (might be able to use copr but will need to retry)

# need a specific version of alsa-ucm not included in f42 yet, eventually should be able to update it but for now just including it
dnf -y install /ctx/alsa-ucm-1.2.12-2.fc41.noarch.rpm
dnf -y install x13s sway x13s firefox labwc sway-config-fedora wireplumber mesa-vulkan-drivers mesa-dri-drivers neovim NetworkManager-wifi pavucontrol pipewire-pulseaudio wireplumber flatpak git fuzzel tuigreet

# firmware
# taken from https://www.rpmfind.net/linux/RPM/openmandriva/cooker/x86_64/main/release/adreno-firmware-20250720-1.noarch.html
cp -n -r /ctx/usr /

# adding kargs from ubuntu 25.10 daily as of aug 2 2025
echo 'kargs = ["clk_ignore_unused", "pd_ignore_unused", "arm64.nopauth"]' >> /usr/lib/bootc/kargs.d/x13s.toml 
echo 'match-architectures = ["aarch64"]' >> /usr/lib/bootc/kargs.d/x13s.toml

#adding install command
mkdir -p /boot/grub2
echo 'set devicetree="dtb/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb"' >> /boot/grub2/user.cfg # probably does not work due to anaconda shenanigans; i've put it in the pre but idk if that will even work

#configs

#greetd
cp /ctx/sway-run /usr/local/bin/ # doing it this way to enable pixman renderer
cp /ctx/greetd.toml /etc/greetd/config.toml
#todo: add greetd user to shadow

#sway
cp /ctx/99*.conf /etc/sway/config.d/
#waybar
cp /ctx/waybar/* /etc/xdg/waybar/ 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
