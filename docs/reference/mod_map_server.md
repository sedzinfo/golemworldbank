# Choropleth map module - server

Populates the indicator choices from `mfi` and renders the animated
choropleth map for the indicator selected by the user.

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
  `Indicator Name`, `Country Code`, `Year`, `value` columns).

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
