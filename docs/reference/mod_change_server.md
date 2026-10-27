# Change (%) tab - server

Runs
[`indicator_change()`](https://sedzinfo.github.io/golemworldbank/reference/indicator_change.md)
for the chosen country, years and checkboxes, and shows how many
indicators increased and decreased, and its two tables with
[`render_change_table()`](https://sedzinfo.github.io/golemworldbank/reference/render_change_table.md).
Asks for two different years, and shows the error of
[`indicator_change()`](https://sedzinfo.github.io/golemworldbank/reference/indicator_change.md)
(no data in either year) in place of the tables.

## Usage

``` r
mod_change_server(id, mfi)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_change_ui()`](https://sedzinfo.github.io/golemworldbank/reference/mod_change_ui.md).

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
  mod_change_server("change", mfi)
}
} # }
```
