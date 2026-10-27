# Country Comparison tab - server

Whenever the countries change, offers only the indicators that have a
value for at least one of them (keeping the chosen indicator), and draws
[`plot_country_comp()`](https://sedzinfo.github.io/golemworldbank/reference/plot_country_comp.md).

## Usage

``` r
mod_country_comp_server(id, mfi)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_country_comp_ui()`](https://sedzinfo.github.io/golemworldbank/reference/mod_country_comp_ui.md).

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
  mod_country_comp_server("country_comp", mfi)
}
} # }
```
