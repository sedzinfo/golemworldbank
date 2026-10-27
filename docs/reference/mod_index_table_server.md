# Index tab - server

Draws the table of
[`render_index_table()`](https://sedzinfo.github.io/golemworldbank/reference/render_index_table.md).

## Usage

``` r
mod_index_table_server(id, mfi, indicator_info)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_index_table_ui()`](https://sedzinfo.github.io/golemworldbank/reference/mod_index_table_ui.md).

- mfi:

  Data frame of World Bank indicator values, with an `Indicator Name`
  column.

- indicator_info:

  Data frame of indicator topics and definitions (see
  [indicator_info](https://sedzinfo.github.io/golemworldbank/reference/indicator_info.md)).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_index_table_server("index_table", mfi, indicator_info)
}
} # }
```
