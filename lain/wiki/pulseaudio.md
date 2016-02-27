[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

Shows and controls PulseAudio volume with a textbox.

	volumewidget = lain.widgets.pulseaudio()

### input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout seconds | int | 5
`cmd` | PulseAudio command | string | ```pacmd list-sinks | sed -n -e '0,/*/d' -e '/base volume/d' -e '/volume:/p' -e '/muted:/p'```
`scallback` | PulseAudio Sink callback | function | nil  
`settings` | User settings | function | empty function

`cmd` catch infos from current used sink. You can redefine it, being sure that the ouput is something like this:

```shell
  * index: 0
	volume: 0:  100% 1:  100%
	muted: no
```

If `sed` doesn't work, you can try with `grep`:

```shell
pacmd list-sinks | grep -e $(pactl info | grep -e 'ink' | cut -d' ' -f3) -e 'volume: front' -e 'muted'
```

`scallback` is a callback function to update `cmd`, in case you switch between audio channels and therefore PulseAudio sink changes. If default `cmd` works for you, you can tell `scallback` to work in the same way:

```lua
scallback = function()
    return "pacmd list-sinks | sed -n -e '0,/*/d' -e '/base volume/d' -e '/volume:/p' -e '/muted:/p'"
end
```

`settings` can use the following variables:

Variable | Meaning | Type | Values
--- | --- | --- | ---
`volume_now.left` | Front left level | int | 0-100
`volume_now.right` | Front right level | int | 0-100
`volume_now.muted` | Sink mute status | string | "yes", "no"

### output table

Variable | Meaning | Type
--- | --- | --- 
`widget` | The widget | `wibox.widget.textbox`
`sink` | PulseAudio sink | int
`update` | Update `widget` | function

You can control the widget with key bindings like these:

```lua
-- PulseAudio volume control
awful.key({ altkey }, "Up",
    function ()
        os.execute(string.format("pactl set-sink-volume %d -- +1%%", volumewidget.sink))
        volumewidget.update()
    end),
awful.key({ altkey }, "Down",
    function ()
        os.execute(string.format("pactl set-sink-volume %d -- -1%%", volumewidget.sink))
        volumewidget.update()
    end),
awful.key({ altkey }, "m",
    function ()
        if volumewidget.muted == "yes" then
            os.execute(string.format("pactl set-sink-mute %d no", volumewidget.sink))
        else
            os.execute(string.format("pactl set-sink-mute %d yes", volumewidget.sink))
        end
        volumewidget.update()
    end),
```

where `altkey = "Mod1"`.