[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

Monitors network interfaces and shows current traffic in a textbox. 

    mynet = lain.widgets.net()

### input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout seconds | int | 2
`iface` | Network device | string | autodetected
`units` | Units | int | 1024 (kilobytes) 
`notify` | Display "no carrier" notifications | string | "on"
`screen` | Notifications screen | int | 1
`settings` | User settings | function | empty function

Possible other values for `units` are 1 (byte) or multiple of 1024: 1024^2 (mb), 1024^3 (gb), and so on.

If `notify = "off"` is set, the widget won't display a notification when there's no carrier.

`settings` can use the following `iface` related strings:

- `net_now.carrier` ("0", "1");
- `net_now.state` ("up", "down");
- `net_now.sent` and `net_now.received` (numbers).

### output

A textbox.

### Setting `iface` manually

If the widget [spawns a "no carrier" notification and you are sure to have an active network device](https://github.com/copycat-killer/lain/issues/102), then autodetection is probably not working. In this case you can set `iface` manually. You can see which device is **UP** with the following command:

```shell
ip link show
```

### Two widgets for upload/download rates from the same `iface`

[Read here](https://github.com/copycat-killer/lain/issues/61).