# Country Comparison tab - UI

A picker for one or more countries, one for the indicator, and the line
chart of
[`plot_country_comp()`](https://sedzinfo.github.io/golemworldbank/reference/plot_country_comp.md).

## Usage

``` r
mod_country_comp_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_country_comp_ui("country_comp"))
} # }
```
