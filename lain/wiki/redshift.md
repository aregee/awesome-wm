[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

### What is Redshift? #

[**Project homepage**](http://jonls.dk/redshift/)

>**Redshift** is an application that adjusts the computer display's color temperature based upon the Sun's apparent position in relation to the user's location on Earth. 

>The program is free software, inspired by the proprietary f.lux, and can be used to reduce eye strain as well as insomnia and delayed sleep phase syndrome.

>The computer display's color temperature transitions evenly from night to daytime temperature to allow the user's eyes to slowly adapt. At night, the color temperature is low and is typically 3000–4000 K (default is 3500 K), preferably matching the room's lighting temperature. Typical color temperature during the daytime is 5500–6500 K (default is 5500 K).

**Source:** [Wikipedia](https://en.wikipedia.org/wiki/Redshift_%28software%29)



### Preparations

**Redshift must be installed** on your system if you want to use this widget.

Packages should be available for most distributions (i.e. [Ubuntu](http://packages.ubuntu.com/search?keywords=redshift&searchon=names&suite=all&section=all), [Arch](https://www.archlinux.org/packages/?q=redshift) or [Debian](https://packages.debian.org/jessie/redshift)).    
Source code and build instructions can be found on Github [here](https://github.com/jonls/redshift).

You also need a valid config file. Please see the [project homepage](http://jonls.dk/redshift/) for details. 

**An example redshift.conf file:**

    ; ~/.config/redshift.conf
    ; Global settings for redshift
    [redshift]
    ; Set the day and night screen temperatures
    temp-day=5700
    temp-night=3500

    ; Enable/Disable a smooth transition between day and night
    ; 0 will cause a direct change from day to night screen temperature. 
    ; 1 will gradually increase or decrease the screen temperature
    transition=1

    ; Set the screen brightness. Default is 1.0
    ;brightness=0.9
    ; It is also possible to use different settings for day and night since version 1.8.
    ;brightness-day=0.7
    ;brightness-night=0.4
    ; Set the screen gamma (for all colors, or each color channel individually)
    gamma=0.8
    ;gamma=0.8:0.7:0.8

    ; Set the location-provider: 'geoclue', 'gnome-clock', 'manual'
    ; type 'redshift -l list' to see possible values
    ; The location provider settings are in a different section.
    location-provider=manual

    ; Set the adjustment-method: 'randr', 'vidmode'
    ; type 'redshift -m list' to see all possible values
    ; 'randr' is the preferred method, 'vidmode' is an older API
    ; but works in some cases when 'randr' does not.
    ; The adjustment method settings are in a different section.
    adjustment-method=randr

    ; Configuration of the location-provider:
    ; type 'redshift -l PROVIDER:help' to see the settings
    ; ex: 'redshift -l manual:help'
    [manual]
    lat=32.0
    lon=-40.0

    ; Configuration of the adjustment-method
    ; type 'redshift -m METHOD:help' to see the settings
    ; ex: 'redshift -m randr:help'
    ; In this example, vidmode is configured to adjust screen 1. 
    ; Note that the numbering starts from 0, so this is actually the second screen.
    [vidmode]
    screen=0

You have to match the location settings to your personal situation:    
Adjust the `lat` and `lon` variables - You can use google maps or wikipedia to get the approximate coordinates.

You might also want to modify the color temperatures to fit your preferences.

### Using the widget

This widget provides several functions that can be used to control Redshift:

* `redshift:toggle()`:   Toggles Redshift's color adjustments on or off.
* `redshift:on()`:   Activates Redshift.
* `redshift:off()`:   This will remove the current color adjustment. (It will not kill the redshift process, however!)
* `redshift:attach(widget, update_function)`:   Attach to a (text or icon) widget.    
    Click on the widget to toggle redshift on or off. This will also auto-launch Redshift along with Awesome WM.    
    `update_function` can be used to modify the icon/text and will be triggered each time redshift changes its status. (See the examples below.)
* `redshift:is_active()`: Returns *true* if redshift is currently modifying the screen color.

#### Usage examples

##### imagebox status widget (with icon)
```lua
-- Redshift widget
icons_dir = require("lain.helpers").icons_dir
local rs_on = icons_dir .. "/redshift/redshift_on.png"
local rs_off = icons_dir .. "/redshift/redshift_off.png"

myredshift = wibox.widget.imagebox(rs_on)
redshift:attach(
    myredshift,
    function ()
        if redshift:is_active() then
            myredshift:set_image(rs_on)
        else
            myredshift:set_image(rs_off)
        end 
    end 
)
```
Then add the `myredshift` widget to your panel.

##### textbox status widget

```lua
-- Redshift widget
myredshift = wibox.widget.textbox("RS")
redshift:attach(
    myredshift,
    function ()
        if redshift:is_active() then
            myredshift:set_text("RS on")
        else
            myredshift:set_text("RS off")
        end 
    end
)
```
Then add the `myredshift` widget to your panel.

##### keybinding

Add this to the keybindings in your rc.lua:
```lua
-- Toggle redshift with Mod+Shift+t
 awful.key({ modkey, "Shift"   }, "t",   function () redshift:toggle()   end) ,
```

