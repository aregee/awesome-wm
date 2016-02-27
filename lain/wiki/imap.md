[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

Shows mail count in a textbox fetching over IMAP.

	myimapcheck = lain.widgets.imap(args)

New mails are notified like this:

	+--------------------------------------------+
	| +---+                                      |
	| |\ /| donald@disney.org has 3 new messages |
	| +---+                                      |
	+--------------------------------------------+

The function takes a table as argument. Required table parameters are:

Variable | Meaning | Type
--- | --- | ---
`server` | Mail server | string
`mail` | User mail | string
`password` | User password | string

while the optional are:

Variable | Meaning | Type | Default
--- | --- | --- | ---
`port` | IMAP port | int | 993
`timeout` | Refresh timeout seconds | int | 60
`is_plain` | Define whether `password` is a plain password (true) or a function that retrieves it (false) | boolean | false
`followmouse` | Notification behaviour | boolean | false
`settings` | User settings | function | empty function

Let's focus better on `is_plain`.

The reason why it's false by default is to discourage the habit of storing passwords in plain.

So you can set your password in plain like this:

    myimapcheck = lain.widgets.imap({
        is_plain = true,
        password = "myplainpassword",
        [...]
    })

and you'll have the same security provided by `~/.netrc`.

**Or** you can use a keyring, like [python keyring](https://pypi.python.org/pypi/keyring):

    myimapcheck = lain.widgets.imap({
        password = "keyring get mymail",
        [...]
    })

When `is_plain == false`, it *executes* `password` before using it, so you can also use whatever password fetching solution you want.

`settings` can use the value `mailcount`, an integer greater or equal to zero, and can modify `mail_notification_preset` table, which will be the preset for the naughty notifications. Check [here](http://awesome.naquadah.org/doc/api/modules/naughty.html#notify) for the list of variables it can contain. 

Default definition:

    mail_notification _preset = {
       icon = lain/icons/mail.png,
       position = "top_left"
    }

Note that `mailcount` is 0 either if there are no new mails or credentials are invalid, so make sure you get the right settings.

In multiple screen setups, the default behaviour is to show a visual notification pop-up window on the first screen. By setting `followmouse` to `true` it will be shown on the current mouse screen.

***This widget is asynchronous***, so you can have multiple instances at the same time.

### output 

A textbox.