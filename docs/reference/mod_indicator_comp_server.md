# Indicator Comparison tab - server

Whenever the country changes, offers only the indicators that have a
value for it (keeping the chosen ones), and draws
[`plot_indicator_comp()`](https://sedzinfo.github.io/golemworldbank/reference/plot_indicator_comp.md).

## Usage

``` r
mod_indicator_comp_server(id, mfi)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_indicator_comp_ui()`](https://sedzinfo.github.io/golemworldbank/reference/mod_indicator_comp_ui.md).

- mfi:

  Data frame of World Bank indicator values (long format, with
  `Country Name`, `Indicator Name`, `Year`, `value` columns).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_indicator_comp_server("indicator_comp", mfi)
}
} # }
```
