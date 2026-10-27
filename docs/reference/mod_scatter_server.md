# Scatterplot tab - server

Fills both indicator pickers with every indicator of `mfi` (on the
server, as the list is long) and draws
[`plot_cor()`](https://sedzinfo.github.io/golemworldbank/reference/plot_cor.md)
for the chosen pair.

## Usage

``` r
mod_scatter_server(id, mfi, country_code)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_scatter_ui()`](https://sedzinfo.github.io/golemworldbank/reference/mod_scatter_ui.md).

- mfi:

  Data frame of World Bank indicator values (long format, with
  `Indicator Name`, `Country Name`, `Year`, `value` columns).

- country_code:

  Data frame mapping countries to region, with columns `Country Code`,
  `Short Name`, `Region`, see
  [country_code](https://sedzinfo.github.io/golemworldbank/reference/country_code.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_scatter_server("scatter", mfi, country_code)
}
} # }
```
