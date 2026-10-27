# Barplot tab - UI

A picker for the indicator, one for the number of countries (top 30, 50
or 100) and one for the country to follow (its bar is red), above the
bar chart race of
[`plot_bar()`](https://sedzinfo.github.io/golemworldbank/reference/plot_bar.md).

## Usage

``` r
mod_bar_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_bar_ui("bar"))
} # }
```
