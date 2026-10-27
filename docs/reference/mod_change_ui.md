# Change (%) tab - UI

A country picker, the two years to compare, the two checkboxes of
[`indicator_change()`](https://sedzinfo.github.io/golemworldbank/reference/indicator_change.md)
(growth rates, changes of sign), a note that the comparison is automatic
and needs interpretation, a one-line summary, and the indicators that
increased and decreased, in two tabs.

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
