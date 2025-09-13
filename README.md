# ublue-x13s

## About

This an image for the x13s that aims to provide a sensible base for the hardware, allowing users to pin certain releases to ensure there is always a stable version available for the user on their computer.

Based off universal-blue's template, specifically bootc. I pretty much made this because I was tired of the ubuntu installation having severe performance regressions and wanted to be able to pin a known good release then roll back to it if needed.

The most frustrating part of this was trying to understand what a .dtb is and where I should be putting the .dtb to ensure it was in line with how the sytems were expecting the changes.

### Image features

The base image is a very minimally modified KDE environment. It used to be a lot more involved, but, video hardware and sound were implemented while I was working on this! Hooray. lol.

The image originally didn't have acceleration and needed to work around a few things to use the software renderer. That image is in the `fallback` branch; good for reference for software only installations.

#### slbounce/EL2/KVM

Not in the image at this time; fedora seems to be packaging EL2 but seems to not be working as expected with `slbounce`. `slbounce` can be added however via refind and then compiling your own el2 overlayed dtb. needs fdtoverlay which is provided by i believe dts. there might be an slbounce mod for grub i'm unaware of that would make it a bit more tenable.

However even if you do get slbounce to work and boot you into EL2, the battery and sound will probably not work. So use at your own knowledge.

You can find documentations on the slbounce setup process here: https://github.com/rinabella-gh/ublue-x13s/wiki/x13s-slbounce

## Issues

The main issue I am aware of is that the video camera is untested and presumed to not work. Sleep seems to at least somewhat work, I'm not sure how well. Additionally, bluetooth is untested, but should most likely work.

I have not tested the 5G modem.

There are a few shortcuts that were made due to feasibility. Namely to do with building the installer ISO; there isn't a great way to just insert the dtb to the image, so there is a bunch of hacking around that.

## References

Helpful resources for the X13s:
- https://wiki.gentoo.org/wiki/Lenovo_ThinkPad_X13s
- https://fedoraproject.org/wiki/Thinkpad_X13s
