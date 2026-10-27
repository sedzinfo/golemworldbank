# Index tab - UI

The table of every indicator with its topic and definition.

## Usage

``` r
mod_index_table_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A
[`DT::dataTableOutput`](https://rdrr.io/pkg/DT/man/dataTableOutput.html)
Shiny UI element.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_index_table_ui("index_table"))
} # }
```
