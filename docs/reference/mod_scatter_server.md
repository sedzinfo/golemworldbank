# Scatter correlation module - server

Populates both indicator pickers from `mfi` and renders the animated
bubble scatter plot for the two indicators selected by the user.

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
  `Short Name`, `Region`.

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
