# Indicator index table module - server

Renders the datatable listing every distinct indicator present in `mfi`.

## Usage

``` r
mod_index_table_server(id, mfi)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_index_table_ui()`](https://sedzinfo.github.io/golemworldbank/reference/mod_index_table_ui.md).

- mfi:

  Data frame of World Bank indicator values, with an `Indicator Name`
  column.

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_index_table_server("index_table", mfi)
}
} # }
```
