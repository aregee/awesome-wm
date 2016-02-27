[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

Shows and controls ALSA volume with a textbox.

	volumewidget = lain.widgets.alsa()

### input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout seconds | int | 5
`cmd` | Alsa mixer command | string | "amixer"
`channel` | Mixer channel | string | "Master" 
`settings` | User settings | function | empty function

`cmd` is useful if you need to pass additional arguments to amixer. For instance, users with multiple sound cards may define `cmd = "amixer -c X"` in order to set amixer with card `X`.

`settings` can use the following variables:

Variable | Meaning | Type | Values
--- | --- | --- | ---
`volume_now.level` | Volume level | int | 0-100
`volume_now.status` | Device status | string | "on", "off"

### output table

Variable | Meaning | Type
--- | --- | --- 
`widget` | The widget | `wibox.widget.textbox`
`channel` | Alsa channel | string
`update` | Update `widget` | function

You can control the widget with key bindings like these:

```lua
    -- ALSA volume control
    awful.key({ altkey }, "Up",
        function ()
            os.execute(string.format("amixer set %s 1%%+", volumewidget.channel))
            volumewidget.update()
        end),
    awful.key({ altkey }, "Down",
        function ()
            os.execute(string.format("amixer set %s 1%%-", volumewidget.channel))
            volumewidget.update()
        end),
    awful.key({ altkey }, "m",
        function ()
            os.execute(string.format("amixer set %s toggle", volumewidget.channel))
            volumewidget.update()
        end),
    awful.key({ altkey, "Control" }, "m",
        function ()
            os.execute(string.format("amixer set %s 100%%", volumewidget.channel))
            volumewidget.update()
        end),
```

where `altkey = "Mod1"`.

Toggle mute issue
-----------------

Problems unmuting PCM? Check [here](https://github.com/copycat-killer/awesome-copycats/issues/95).