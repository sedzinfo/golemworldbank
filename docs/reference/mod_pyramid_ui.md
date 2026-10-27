# Pyramid tab - UI

A picker for the country and the animated population pyramid of
[`plot_pyramid()`](https://sedzinfo.github.io/golemworldbank/reference/plot_pyramid.md).

## Usage

``` r
mod_pyramid_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_pyramid_ui("pyramid"))
} # }
```
