# Indicator Comparison tab - UI

A picker for one or more indicators, one for the country, and the line
chart of
[`plot_indicator_comp()`](https://sedzinfo.github.io/golemworldbank/reference/plot_indicator_comp.md).

## Usage

``` r
mod_indicator_comp_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_indicator_comp_ui("indicator_comp"))
} # }
```
