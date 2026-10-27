# Barplot tab - server

Fills the indicator picker with every indicator of `mfi` (on the server,
as the list is long) and draws
[`plot_bar()`](https://sedzinfo.github.io/golemworldbank/reference/plot_bar.md)
for the chosen indicator, number of countries and country to follow.

## Usage

``` r
mod_bar_server(id, mfi)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_bar_ui()`](https://sedzinfo.github.io/golemworldbank/reference/mod_bar_ui.md).

- mfi:

  Data frame of World Bank indicator values (long format, with
  `Indicator Name`, `Country Name`, `Year`, `value` columns).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_bar_server("bar", mfi)
}
} # }
```
