[<- widgets](https://github.com/copycat-killer/lain/wiki/Widgets)

Shows in a textbox the current prices of Bitcoin to USD and Dogecoin to USD using Coinbase and Cryptsy's APIs.

	ccurrwidget = lain.widgets.contrib.ccurr()

### input table

Variable | Meaning | Type | Default
--- | --- | --- | ---
`timeout` | Refresh timeout seconds | int | 600
`btc_url` | URL to Json Bitcoin data | string | Coinbase API
`doge_url` | URL to Json Dogecoin data | string | Cryptsy API
`settings` | User settings | function | empty function

`settings` can use the `price_now` table, which contains the following strings:

- `btc`;
- `doge`.

### output

A textbox.