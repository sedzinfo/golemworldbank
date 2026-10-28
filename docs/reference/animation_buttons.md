# Pause and Stop buttons for an animated plotly chart

Builds the `updatemenus` entry shown next to plotly's own Play button,
used by every animated chart of the app. Pause halts the animation on
the current frame; Stop halts it and jumps back to the first frame.

## Usage

``` r
animation_buttons(first_frame)
```

## Arguments

- first_frame:

  Character. Name of the first animation frame (for these charts, the
  first year).

## Value

A list to pass as `plotly::layout(updatemenus = ...)`.

## Examples

``` r
plotly::layout(p, updatemenus = animation_buttons("1960"))
#> Error: object 'p' not found
```
