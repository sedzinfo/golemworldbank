# Map tab - server

Fills the indicator picker with every indicator of `mfi` (on the server,
as the list is long) and draws
[`plot_map()`](https://sedzinfo.github.io/golemworldbank/reference/plot_map.md)
for the chosen one.

## Usage

``` r
mod_map_server(id, mfi)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_map_ui()`](https://sedzinfo.github.io/golemworldbank/reference/mod_map_ui.md).

- mfi:

  Data frame of World Bank indicator values (long format, with
  `Country Code`, `Country Name`, `Indicator Name`, `Year`, `value`
  columns).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_map_server("map", mfi)
}
} # }
```
