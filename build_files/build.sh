#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

cp jlinton-x13s.repo /etc/yum.repos.d/ # add communtiy repo
dnf install x13s sway x13s alsa-ucm alsa-ucm-utils firefox labwc sway-config-fedora wireplumber mesa-vulkan-drivers mesa-dri-drivers neovim NetworkManager-wifi pavucontrol pipiewire-pulseaudio pipewire-alsa wireplumber flatpak git fuzzel

#firmware
cp -r sc8280xp /lib/firmware/qcom

# adding kargs from ubuntu 25.10 daily as of aug 2 2025
echo 'kargs = ["clk_ignore_unused", "pd_ignore_unused", "arm64.nopauth", "console=tty0", "crashkernel=2G-4G:320M,4G-32G:512M,32G-64G:1024M,64G-128G:2048M,128G-:4096M", "vt.handoff=7"]' >> /usr/lib/bootc/kargs.d/x13s.toml 
echo 'match-architectures = ["aarch64"]' >> /usr/lib/bootc/kargs.d/x13s.toml

#adding install command
#dnf5 -y install /ctx/x13s-settings.rpm
# attempting to add default dtb
mkdir -p /boot/grub2
echo 'set devicetree="dtb/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb"' >> /boot/grub2/user.cfg # probably does not work due to anaconda shenanigans; i've put it in the pre but idk if that will even work

# this is a hack, trying to use this for anaconda to actually add the DTB like it should to the boot iso. im a little doubtful this will work but i really don't want to have to reimpl bootc-image-builder
echo 'set GRUB_DEFAULT_DTB="dtb/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb"' >> /etc/grub.d/00_header
echo 'GRUB_DEFAULT_DTB="dtb/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb"' >> /etc/grub.d/00_header
echo 'set devicetree="dtb/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb"' >> /etc/default/grub

# another attempt at a hack
echo 'set GRUB_DEFAULT_DTB="dtb/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb"' >> /etc/default/grub
echo 'GRUB_DEFAULT_DTB="dtb/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb"' >> /etc/default/grub
echo 'set devicetree="dtb/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb"' >> /etc/default/grub

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
