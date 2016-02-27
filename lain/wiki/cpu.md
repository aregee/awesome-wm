[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

Shows in a textbox the average CPU usage percent for a given amount of time.

	mycpuusage = lain.widgets.cpu()

### input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout seconds | int | 2
`settings` | User settings | function | empty function

`settings` can use the string `cpu_now.usage`, which is the cpu use percentage.

### output

A textbox.
