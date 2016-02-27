Welcome to the Lain wiki!

Dependencies
------------------

Package | Requested by | Reason of choice
--- | --- | ---
alsa-utils | ALSA widgets | /
curl | widgets accessing network resources | Simpler to install and use than LuaSocket. 
imagemagick | album arts in [MPD](https://github.com/copycat-killer/lain/wiki/mpd) notifications | Cairo doesn't do high quality filtering.

Installation
---------------

### Arch Linux

[AUR package](https://aur.archlinux.org/packages/lain-git/)

### Other distributions

    git clone https://github.com/copycat-killer/lain.git ~/.config/awesome/lain

Usage
--------

First, include it into your `rc.lua`:

    local lain = require("lain")

Then check out the submodules you want:

- [Layouts](https://github.com/copycat-killer/lain/wiki/Layouts)
- [Widgets](https://github.com/copycat-killer/lain/wiki/Widgets)
- [Utilities](https://github.com/copycat-killer/lain/wiki/Utilities)