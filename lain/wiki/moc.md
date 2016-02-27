[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

A widget for showing the current song track's information from MOC (Music On Console). Also provides next track notifications using naughty

	mocwidget = lain.widgets.contrib.moc()

Now playing songs are notified like this:

	+--------------------------------------------------------+
	| +-------+                                              |
	| |/^\_/^\| Now playing                                  |
    | |\ O O /| Cannibal Corpse (Hammer Smashed Face) - 1993 |
    | | '.o.' | Hammer Smashed Face (Radio Disney Version)   |
	| +-------+                                              |
	+--------------------------------------------------------+

You need a file like this

     (Front|front|Cover|cover|Art|art|Folder|folder)\.(jpg|jpeg|png|gif)

in the album folder in order to show album art too.

### input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout seconds | int | 1
`music_dir` | Music directory | string | "~/Music"
`cover_size` | Album art notification size | int | 100
`default_art` | Default art | string | ""
`followmouse` | Notification behaviour | boolean | false
`settings` | User settings | function | empty function

Pay attention to case sensitivity when defining `music_dir`.

`settings` can use `moc_now` table, which contains the following string values:

- state (possible values: "PLAY", "PAUSE", "STOP")
- file
- artist
- title
- album
- elapsed (Time elapsed for the current track)
- total (The current track's total time)

and can modify `moc_notification_preset` table, which will be the preset for the naughty notifications. Check [here](http://awesome.naquadah.org/doc/api/modules/naughty.html#notify) for the list of variables it can contain. Default definition:

    moc_notification_preset = {
       title   = "Now playing",
       timeout = 6,
       text    = string.format("%s (%s) - %s\n%s", moc_now.artist,
                 moc_now.album, moc_now.elapsed, moc_now.title)
    }

In multiple screen setups, the default behaviour is to show a visual notification pop-up window on the first screen. By setting `followmouse` to `true` it will be shown on the same screen containing the widget.

### output table

Variable | Meaning | Type
--- | --- | ---
`widget` | The textbox | `wibox.widget.textbox`
`update` | The notification | function

You can control the widget with key bindings like these:

    -- MOC control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            awful.util.spawn_with_shell("mocp -G")
            mocwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            awful.util.spawn_with_shell("mocp -s")
            mocwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            awful.util.spawn_with_shell("mocp -r")
            mocwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            awful.util.spawn_with_shell("mocp -f")
            mocwidget.update()
        end),

where `altkey = "Mod1"`.