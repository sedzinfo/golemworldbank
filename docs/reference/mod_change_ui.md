# What changed module - UI

Renders a country picker, two year pickers, the two noise filters of
[`indicator_change()`](https://sedzinfo.github.io/golemworldbank/reference/indicator_change.md),
a note that the comparison is automatic and needs interpretation, and
two tables (indicators that increased / decreased between the two
years).

## Usage

``` r
mod_change_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_change_ui("change"))
} # }
```
