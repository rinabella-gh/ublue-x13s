# ublue-x13s

## About

This an image for the x13s that aims to provide a sensible base for the hardware, allowing users to pin certain releases to ensure there is always a stable version available for the user on their computer.

Based off universal-blue's template, specifically bootc. I pretty much made this because I was tired of the ubuntu installation having severe performance regressions.

The most frustrating part of this was trying to understand what a .dtb is and where I should be putting the .dtb to ensure it was in line with how the sytems were expecting the changes.

### Image features

The base image has the following features once installed:

- `tuigreeter` for logging in
- `sway` running with the `WLR_RENDERER` set to `pixman` for software rendering with some very slight customization.
  - Even as a software renderer, the performance from `pixman` is very solid. WebGL Aquarium gets a steady 30 FPS.  
- Sound, Wifi, Temperature, and Battery sensors should be working and displayed per the default `sway-fedora-config`
- - Firefox
- Support for flatpaks is added but nothing beyond that; I recommend installing either Bazaar or Warehouse to install further flatpaks.

#### slbounce/EL2/KVM

Not in the image at this time; fedora seems to be packaging EL2 but seems to not be working as expected with `slbounce`. `slbounce` can be added however via refind and then compiling your own el2 overlayed dtb. needs fdtoverlay which is provided by i believe dts. there might be an slbounce mod for grub i'm unaware of that would make it a bit more tenable.

However even if you do get slbounce to work and boot you into EL2, the battery and sound break again. So use at your own knowledge.

## Issues

The two main issues I am aware of at this time are the lack of graphics acceleration and the video camera is untested and presumed to not work. Sleep is totally untested. Additionally, bluetooth is untested, but should most likely work.

There are a few shortcuts that were made due to feasibility. Namely to do with building the installer ISO; there isn't a great way to just insert the dtb to the image. So we try our best.

## References

Helpful resources for the X13s:
- https://wiki.gentoo.org/wiki/Lenovo_ThinkPad_X13s
- https://fedoraproject.org/wiki/Thinkpad_X13s
