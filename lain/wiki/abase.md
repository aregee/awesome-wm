[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

The [asynchronous](https://github.com/copycat-killer/lain/issues/128) version of `base`:

	myasyncbase = lain.widgets.abase()

Read [here](https://github.com/copycat-killer/lain/wiki/base) for the rest.

Use case examples
========
*Do you wrote a widget that could be useful to others as well? Feel free to add it here.*

cmus
----

```lua
cmuswidget = lain.widgets.abase({
    cmd = "cmus-remote -Q",
    settings = function()
        cmus_now = {
            state   = "N/A",
            artist  = "N/A",
            title   = "N/A",
            album   = "N/A"
        }

        for w in string.gmatch(output, "(.-)tag") do
            a, b = w:match("(%w+) (.-)\n")
            cmus_now[a] = b
        end

        -- customize here
        widget:set_text(cmus_now.artist .. " - " .. cmus_now.title)
    end
})
```