# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM ghcr.io/ublue-os/aurora:stable

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:latest
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
# 
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

# custom kargs taken from ubuntu live
# via https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/using_image_mode_for_rhel_to_build_deploy_and_manage_operating_systems/managing-kernel-arguments-in-bootc-systems#how-to-inject-kernel-arguments-at-installation-time_managing-kernel-arguments-in-bootc-systems
RUN cat <<EOF >> /usr/lib/bootc/kargs.d/x13s.toml
kargs = ["clk_ignore_unused", "pd_ignore_unused", "arm64.nopauth", "console=tty0", "crashkernel=2G-4G:320M,4G-32G:512M,32G-64G:1024M,64G-128G:2048M,128G-:4096M", "vt.handoff=7"]
match-architectures = ["aarch64"]
EOF

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    ostree container commit
    


### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
