# Bar chart module - server

Populates the indicator choices from `mfi` and renders the animated bar
chart for the indicator selected by the user.

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
