# Bar chart module - UI

Renders an indicator picker, a top-n picker, a picker for the country to
follow (its bar is red) and an animated ranked bar chart (races
countries by value, one animation frame per year).

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
