=======================
Awesome Multicolor Burn
=======================

--------------------------------------------------------
Minimal functional Dual Head Config for Awesome WM 3.5+
--------------------------------------------------------

:Author: Aregee
:Version: git
:License: BY-NC-SA_
:Source: https://github.com/aregee/configs

Description
===========

A minimal theme crossed between Multicolor and Steamburn, with basic setup 
for dual head display.

Notable features
================

- Autohide widgets (*tell me only when you have to*)
- Autostart applications
- Fast MPD and volume shortcuts (first time you see this trick in Awesome)
- Other shortcuts for copying to the clipboard (goodbye clipboard managers!), toggle wiboxes, widgets popups, screenshots capture, moving and magnifying clients
- Quake drop-down terminal
- Calendar with current day highlighted and months switch with a click
- Elegant notifications for new mails, current song, volume level, hdd critical state, low battery
- OpenWeatherMap integration
- Net carrier status notifier
- Colorful autoupdating icons
- Symbolic tag names
- TXT layoutbox
- PNG wibox bar
- Custom layouts
- No borders when there's only one visible client
- Powerful volume bar
- Menubar menu
- Vi-like client focus
- Nice client border (colors change along with processes status)
- Non-empty tag browsing
- Dynamic useless gaps
- Dynamic tagging
- Screen Lock
- Wallpaper Auto change
- Set Different Wallpaper on each tag

Gallery
=======

**MulticolorSteamBurn** inspired by @copycat-killer

.. image:: http://i.imgur.com/q6U8olD.png

.. image:: http://imgur.com/45RSVb3.png

.. image:: http://i.imgur.com/mQWJeAk.png

.. image:: http://imgur.com/Nc3Dj39.png

.. image:: http://imgur.com/vqpR6c6.png

View More at `here <http://imgur.com/a/RAIb1>`_. and `here <http://imgur.com/a/TJsdx/all>`_. `some more <http://imgur.com/a/exo9d>`_.



Installation
============

Using git you can have the full master branch: ::

    git clone https://github.com/aregee/configs.git

then, move the contents of `configs` to `~/.config/awesome`.

Usage
=====

Switch a theme this way: ::

    cd ~/.config/awesome
    cp rc.lua.theme rc.lua

Alternatively, you can use `switch-theme.sh`_, which will also update to the latest commit.

Then customize your ``rc.lua`` and restart Awesome (``Mod4 + ctrl + r``).


Wallpapers
=============

make `Wallpapers` directory at home (~/) containing wallpapers of your choice named as `wallbase_X.jpg` 

where : X = integer 

e.g. wallbase_2.jpg 

Defaults
========

- common

:terminal:   urxvtc
:chat:       weechat

- user defined

:browser:    google-chrome
:browser2:   firefox
:gui_editor: atom
:graphics:   gimp

to use `sublime-text` and `gnome-terminal`
	change `atom` to `subl` and `urxvtc` to `gnome-terminal` in rc.lua

- short keys

:modkey + q: google-chrome
:modkey + i: firefox
:modkey + s: atom
:modkey + s: weechat


