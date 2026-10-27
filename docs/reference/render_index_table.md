# Build the indicator index DataTable

Builds a non-paginated
[`DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html) listing
every distinct indicator name present in `mfi`, with its World Bank
topic and definition.

## Usage

``` r
render_index_table(mfi, indicator_info)
```

## Arguments

- mfi:

  Data frame of World Bank indicator values, with an `Indicator Name`
  column.

- indicator_info:

  Data frame with `Indicator Name`, `Topic` and `Definition` columns
  (see
  [indicator_info](https://sedzinfo.github.io/golemworldbank/reference/indicator_info.md)).

## Value

A [`DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html)
htmlwidget.

## Examples

``` r
render_index_table(mfi, indicator_info)
```
