# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
#FROM ghcr.io/ublue-os/aurora:stable
FROM quay.io/fedora/fedora-bootc:42-aarch64

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
# https://github.com/coreos/layering-examples/blob/c068b6524c8eca38eca465315758c853fdb20335/replace-kernel/Containerfile#L4
RUN rpm-ostree cliwrap install-to-root /

# custom kargs taken from ubuntu live
# via https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/using_image_mode_for_rhel_to_build_deploy_and_manage_operating_systems/managing-kernel-arguments-in-bootc-systems#how-to-inject-kernel-arguments-at-installation-time_managing-kernel-arguments-in-bootc-systems

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    ostree container commit
    


### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
