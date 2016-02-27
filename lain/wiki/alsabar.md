[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

Shows and controls alsa volume with a progressbar; provides tooltips, notifications, and color changes at mute/unmute switch.

	volume = lain.widgets.alsabar()

* Left click: Launch `alsamixer` in your `terminal`.
* Right click: Mute/unmute.
* Scroll wheel: Increase/decrase volume.

The function takes a table as optional argument, which can contain:

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout seconds | int | 5
`settings` | User settings | function | empty function
`width` | Bar width | int | 63
`height` | Bar height | int | 1
`ticks` | Set bar ticks on | boolean | false
`ticks_size` | Ticks size | int | 7
`vertical` | Set the bar vertical | boolean | false
`command` | ALSA mixer command | string | "amixer"
`channel` | Mixer channel | string | "Master" 
`step` | Step at which volume is increased/decreased | string | "2%"
`colors` | Bar colors | table | see **colors**
`notifications` | Notifications settings | table | see **notifications**
`followmouse` | Notification behaviour | bool | false

`command` is useful if you need to pass additional arguments to amixer. For instance, users with multiple sound cards may define `command = "amixer -c X"` in order to set amixer with card `X`.

### colors

Variable | Meaning | Type | Default
--- | --- | --- | ---
`background` | Bar backgrund color | string | `beautiful.bg_normal`
`mute` | Bar mute color | string | "#EB8F8F"
`unmute` | Bar unmute color | string | "#A4CE8A"

### notifications

Variable | Meaning | Type | Default
--- | --- | --- | ---
`font` | Notifications font | string | The one defined in `beautiful.font`
`font_size` | Notifications font size | string | "11"
`color` | Notifications color | string | `beautiful.fg_normal`
`bar_size` | Wibox height | int | 18
`screen` | Notifications screen | int | 1

It's **crucial** to set `notifications.bar_size` to your `mywibox[s]` height.

`settings` can use the following variables:

Variable | Meaning | Type | Values
--- | --- | --- | ---
`volume_now.level` | Self explained | int | 0-100
`volume_now.status` | Device status | string | "on", "off"
### output table

Variable | Meaning | Type
--- | --- | ---
`bar` | The widget | `awful.widget.progressbar`
`channel` | Alsa channel | string
`card` | Alsa card | string
`step` | Increase/decrease step | string
`notify` | The notification | function

In multiple screen setups, the default behaviour is to show a visual notification pop-up window on the first screen when the widget is hovered with the mouse. By setting `followmouse` to `true` it will be shown on the same screen containing the widget.

You can control the widget with key bindings like these:

```lua
    -- ALSA volume control
    awful.key({ altkey }, "Up",
        function ()
            os.execute(string.format("amixer set %s %s+", volume.channel, volume.step))
            volume.update()
        end),
    awful.key({ altkey }, "Down",
        function ()
            os.execute(string.format("amixer set %s %s-", volume.channel, volume.step))
            volume.update()
        end),
    awful.key({ altkey }, "m",
        function ()
            os.execute(string.format("amixer set %s toggle", volume.channel))
            volume.update()
        end),
    awful.key({ altkey, "Control" }, "m",
        function ()
            os.execute(string.format("amixer set %s 100%%", volume.channel))
            volume.update()
        end),
```

where `altkey = "Mod1"`.

Toggle mute issue
-----------------

Problems unmuting PCM? Check [here](https://github.com/copycat-killer/awesome-copycats/issues/95).