[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

Shows in a textbox the remaining time and percentage capacity of your laptop battery, as well as
the current wattage.

Displays a notification when battery is low or critical.

	mybattery = lain.widgets.bat()

### input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout seconds | int | 30
`battery` | Identifier of the battery | string | "BAT0"
`notify` | Enable notifications | string | "on"
`settings` | User settings | function | empty function

To disable warning notifications, set `notify` to `"off"`.

`settings` can use the `bat_now` table, which contains the following strings:

- `status` ("Not present", "Charging", "Discharging");
- `perc`;
- `time`;
- `watt`.

and can modify the following two tables, which will be the preset for the naughty notifications: 
* `bat_notification_low_preset`(used if battery charge level <= 15)
* `bat_notification_critical_preset` (used if battery charge level <= 5)

Check [here](http://awesome.naquadah.org/doc/api/modules/naughty.html#notify) for the list of variables they can contain.  

**Default definition:**
```lua
bat_notification_low_preset = {
        title = "Battery low",
        text = "Plug the cable!",
        timeout = 15,
        fg = "#202020",
        bg = "#CDCDCD"
}
```
```lua
bat_notification_critical_preset = {
        title = "Battery exhausted",
        text = "Shutdown imminent",
        timeout = 15,
        fg = "#000000",
        bg = "#FFFFFF"
}
```

### output

A textbox.

### Note

If your widget is always on "N/A" with default settings, then `BAT0` is not your battery file. Locate the right one in  `/sys/class/power_supply/` and set `battery` properly. 
For instance, with `BAT1`:

```lua
batwidget = lain.widgets.bat({
    battery = "BAT1",
    settings = function()
        -- do stuff
    end
})

```
