# About tab - UI

A static page: what the app shows, where the data comes from, the
acknowledgments, and the license and links of the package. It has no
inputs, so it has no module server.

## Usage

``` r
mod_about_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(mod_about_ui("about"))
} # }
```
