#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# adding kargs from ubuntu 25.10 daily as of aug 2 2025
echo 'kargs = ["clk_ignore_unused", "pd_ignore_unused", "arm64.nopauth", "console=tty0", "crashkernel=2G-4G:320M,4G-32G:512M,32G-64G:1024M,64G-128G:2048M,128G-:4096M", "vt.handoff=7"]' >> /usr/lib/bootc/kargs.d/x13s.toml 
echo 'match-architectures = ["aarch64"]' >> /usr/lib/bootc/kargs.d/x13s.toml

#adding install command
#dnf5 -y install /ctx/x13s-settings.rpm
# attempting to add default dtb
export GRUB_DEFAULT_DTB="dtb/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb"
echo 'GRUB_DEFAULT_DTB="dtb/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb"' >> /etc/default/grub
echo 'GRUB_DEFAULT_DTB="dtb/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb"' > /boot/grub2/user.cfg
# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
