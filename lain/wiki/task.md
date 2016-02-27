[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

Attaches a [taskwarrior](http://taskwarrior.org) notification to a widget, and lets to add/search tasks from the promptbox.

```lua
    lain.widgets.contrib.task:attach(widget, args)
```

`args` is an optional table which can contain:

Variable | Meaning | Type | Default
--- | --- | --- | ---
`font_size` | Notifcation font size | int | 12
`fg` | Notification popup foreground color | string | `beautiful.fg_normal`
`bg` | Notification popu background color | string | `beautiful.bg_normal`
`position` | Notification popup position | string | "top_right"
`timeout` | Notification timeout seconds | int | 7
`scr_pos` | Notification screen | int | 1
`followmouse` | Notification behaviour | boolean | false

`position` possible values are defined [here](http://awesome.naquadah.org/doc/api/modules/naughty.html#notify).

Notification will show the output of `task` command.

In multiple screen setups, the default behaviour is to show a visual notification pop-up window on the first screen. By setting `followmouse` to `true` it will be shown on the same screen containing the widget.

You can call the notification with a key binding like this:

```lua
awful.key({ modkey, altkey }, "t", function () lain.widgets.contrib.task.show(scr) end),
```

where ``altkey = "Mod1"`` and `scr` indicates the screen which you want the notification in.

And you can prompt to add/search a task with key bindings like these:

```lua
awful.key({ modkey,         }, "t", lain.widgets.contrib.task.prompt_add),
awful.key({ modkey, "Shift" }, "t", lain.widgets.contrib.task.prompt_search),
```