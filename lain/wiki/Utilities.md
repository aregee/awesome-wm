separators
----------

Adds Cairo separators.

    local separators = lain.util.separators

A separator function `separators.separator` takes two color arguments, defined as strings. `"alpha"` argument is allowed. [Example](https://github.com/copycat-killer/awesome-copycats/blob/master/rc.lua.powerarrow-darker#L255-256). 

You can customize height and width by setting `awful_widget_height` and `separators_width` in your `theme.lua`. Default values are 0 and 9, respectively.

List of functions:

     +-- separators
     |
     |`-- arrow_right()        Draw a right arrow.
     |`-- arrow_left()         Draw a left arrow.

markup
------

Mades markup easier.

    local markup = lain.util.markup

List of functions:

     +-- markup
     |
     |`-- bold()        Set bold.
     |`-- italic()      Set italicized text.
     |`-- strike()      Set strikethrough text.
     |`-- underline()   Set underlined text.
     |`-- monospace()   Set monospaced text.
     |`-- big()         Set bigger text.
     |`-- small()       Set smaller text.
     |`-- font()        Set the font of the text.
     |
     |`--+ bg
     |   |
     |   |`-- color()   Set background color.
     |   |`-- focus()   Set focus  background color.
     |   |`-- normal()  Set normal background color.
     |    `-- urgent()  Set urgent background color.
     |
     |`--+ fg
     |   |
     |   |`-- color()   Set foreground color.
     |   |`-- focus()   Set focus  foreground color.
     |   |`-- normal()  Set normal foreground color.
     |    `-- urgent()  Set urgent foreground color.
     |
     |`-- focus()       Set both foreground and background focus  colors.
     |`-- normal()      Set both foreground and background normal colors.
      `-- urgent()      Set both foreground and background urgent colors.

they all take one argument, which is the text to markup, except `font`, `fg.color` and `bg.color`:

    markup.font(font, text)
    markup.fg.color(color, text)
    markup.bg.color(color, text)

`focus`, `normal` and `urgent` use `beautiful` variables.

dynamic tagging
---------------

That is:

- add a new tag;
- rename current tag;
- move current tag;
- remove current tag.

If you delete a tag, any rule set on it shall be broken, so be careful.

Use it with key bindings like these:

    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag(mypromptbox) end),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag(mypromptbox) end),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(1) end),  -- move to next tag
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(-1) end), -- move to previous tag
    awful.key({ modkey, "Shift" }, "d", function () lain.util.remove_tag() end),

**Note** that these function won't work properly with [Copland theme](https://github.com/copycat-killer/awesome-copycats) or any other configuration that already uses a dynamic tagging module like [Eminent](https://github.com/copycat-killer/awesome-copycats/tree/master/eminent).

useless\_gaps\_resize
---------------------

Changes `beautiful.useless_gaps_width` on the fly.

The function takes an integer argument, being the amount of pixel to add/remove to gaps.

You could use it with these keybindings:

    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end),
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end),

where `altkey=Mod1`, or you could use it like this:

    mywidget:buttons(awful.util.table.join (
          awful.button({}, 4, function() lain.util.useless_gaps_resize(-1) end),
          awful.button({}, 5, function() lain.util.useless_gaps_resize(1) end)
          end)
    ))

so when hovering the mouse over `mywidget`, you can adjust useless gaps size by scrolling with the mouse wheel.

tag\_view\_nonempty
-------------------

This function lets you jump to the next/previous non-empty tag.
It takes two arguments:

* `direction`: `1` for next non-empty tag, `-1` for previous.
* `sc`: Screen which the taglist is in. Default is `mouse.screen` or `1`. This
  argument is optional.

You can use it with key bindings like these:

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),

where `altkey = "Mod1"`.

menu\_clients\_current\_tags
----------------------------

Similar to `awful.menu.clients`, but this menu only shows the clients
of currently visible tags. Use it with a key binding like this:

    awful.key({ "Mod1" }, "Tab",
    function()
        awful.menu.menu_keys.down = { "Down", "Alt_L", "Tab", "j" }
        awful.menu.menu_keys.up = { "Up", "k" }
        lain.util.menu_clients_current_tags({ width = 350 }, { keygrabber = true })
    end),

magnify\_client
---------------

Set a client to floating and resize it in the same way the "magnifier"
layout does it. Place it on the "current" screen (derived from the mouse
position). This allows you to magnify any client you wish, regardless of
the currently used layout. Use it with a client keybinding like this:

	clientkeys = awful.util.table.join(
		...
		awful.key({ modkey, "Control" }, "m", lain.util.magnify_client),
		...
	)

If you want to "de-magnify" it, just retype the keybinding.

niceborder\_{focus, unfocus}
----------------------------

By default, your `rc.lua` contains something like this:

	client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
	client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

You can change it to this:

	client.connect_signal("focus", lain.util.niceborder_focus(c))
	client.connect_signal("unfocus", lain.util.niceborder_unfocus(c))

Now, when a client is focused or unfocused, Awesome will look up its
nice value in `/proc/<pid>/stat`. If it's less than 0, the client is
classified as "high priority"; if it's greater than 0, the client is
classified as "low priority". If it's equal to 0, nothing special
happens.

This requires to define additional colors in your `theme.lua`. For example:

	theme.border_focus_highprio  = "#FF0000"
	theme.border_normal_highprio = "#A03333"

	theme.border_focus_lowprio   = "#3333FF"
	theme.border_normal_lowprio  = "#333366"