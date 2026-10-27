# Scatterplot tab - UI

Pickers for the indicator of the x axis and of the y axis, and the
animated bubble chart of
[`plot_cor()`](https://sedzinfo.github.io/golemworldbank/reference/plot_cor.md).

## Usage

``` r
mod_scatter_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_scatter_ui("scatter"))
} # }
```
