#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

cp /ctx/jlinton-x13s.repo /etc/yum.repos.d/ # add communtiy repo (might be able to use copr but will need to retry)

# KDE
rmdir /root # workaround for root-files being pulled in
dnf -y group install kde-desktop-environment #@kde-desktop is more minimal

# need a specific version of alsa-ucm not included in f42 yet, eventually should be able to update it but for now just including it
dnf -y install x13s firefox wireplumber mesa-vulkan-drivers mesa-dri-drivers neovim NetworkManager-wifi pavucontrol pipewire-pulseaudio flatpak git
# firmware
# taken from https://www.rpmfind.net/linux/RPM/openmandriva/cooker/x86_64/main/release/adreno-firmware-20250720-1.noarch.html
cp -n -r /ctx/usr /

# adding required kargs
echo 'kargs = ["clk_ignore_unused", "pd_ignore_unused", "arm64.nopauth"]' >> /usr/lib/bootc/kargs.d/x13s.toml 
echo 'match-architectures = ["aarch64"]' >> /usr/lib/bootc/kargs.d/x13s.toml

#adding install command
mkdir -p /boot/grub2
echo 'set devicetree="dtb/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb"' >> /boot/grub2/user.cfg # probably does not work due to anaconda shenanigans; i've put it in the pre but idk if that will even work

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
