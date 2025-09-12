# ublue-x13s

## About

This an image for the x13s that aims to provide a sensible base for the hardware, allowing users to pin certain releases to ensure there is always a stable version available for the user on their computer.

Based off universal-blue's template. I pretty much made this because I was tired of the ubuntu installation having severe performance regressions.

The most frustrating part of this was trying to understand what a .dtb is and where I should be putting the .dtb to ensure it was in line with how the sytems were expecting the changes.

### Image features

The base image has the following features once installed:

- `tuigreeter` for logging in
- `sway` running with the `WLR_RENDERER` set to `pixman` for software rendering with some very slight customization.
  - Even as a software renderer, the performance from `pixman` is very solid. WebGL Aquarium gets a steady 30 FPS.  
- Sound, Wifi, Temperature, and Battery sensors should be working and displayed per the default `sway-fedora-config`
- - Firefox
- Support for flatpaks is added but nothing beyond that; I recommend installing eithr Bazaar or Warehouse to install further flatpaks.
- 
## Issues

The two main issues I am aware of at this time are the lack of graphics acceleration and the video camera is untested and presumed to not work. Additionally, bluetooth is untested, but should most likely work.

## References

Helpful resources for the X13s:
- https://wiki.gentoo.org/wiki/Lenovo_ThinkPad_X13s
- https://fedoraproject.org/wiki/Thinkpad_X13s
