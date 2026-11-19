# Animated charts

The Pyramid, Barplot, Scatterplot and Choropleth tabs of the
[golemworldbank app](https://sedzinfo.shinyapps.io/golemworldbank/) draw
charts that move through the years. In R they are
[`plot_pyramid()`](https://sedzinfo.github.io/golemworldbank/reference/plot_pyramid.md),
[`plot_bar()`](https://sedzinfo.github.io/golemworldbank/reference/plot_bar.md),
[`plot_cor()`](https://sedzinfo.github.io/golemworldbank/reference/plot_cor.md)
and
[`plot_map()`](https://sedzinfo.github.io/golemworldbank/reference/plot_map.md).
[Indicator charts in
R](https://sedzinfo.github.io/golemworldbank/articles/golemworldbank.md)
shows how to find the names of the countries and indicators.

The app draws its charts across the whole window with `font_style`, a 20
px font. This page is narrower, so its charts are drawn with a 12 px
font, `font_style = list(size = 12)`.

``` r

library(golemworldbank)
```

## Play the years

Each chart has a frame per year of its data. Play plays the years one
after the other, Pause stops on the current year and Stop goes back to
the first year. The slider under the chart goes straight to the year you
pick.

## Population pyramid

[`plot_pyramid()`](https://sedzinfo.github.io/golemworldbank/reference/plot_pyramid.md)
draws, for one country, the share of each five-year age group in the
male population, to the left, and in the female population, to the
right. Its data is `mfi_population`:

``` r

plot_pyramid(mfi_population, country = "Greece", font_style = list(size = 12))
```

The male bars are drawn with negative values, so that the two sexes
stand back to back, but the labels on the bars and the axis show them
positive. A click on Male or Female in the legend hides or shows its
bars, and they stay hidden while the years play.

## Bar chart race

[`plot_bar()`](https://sedzinfo.github.io/golemworldbank/reference/plot_bar.md)
ranks the countries by one indicator in every year and draws the largest
`top_n` of them as bars, 20 by default. As the years play, a country
that overtakes another moves up. Each bar shows the country and its
value, to 3 significant digits, and the year is printed large and gray
in the bottom right corner. The bar of `country` is red, so you can
follow it through the race:

``` r

plot_bar(
  mfi_table(),
  indicator = "GDP (current US$)",
  font_style = list(size = 12),
  country = "Greece",
  top_n = 50
)
```

A country’s missing years between two years with a value are filled by
linear interpolation, so that it does not drop out of the race for a
year and come back. Nothing is filled before its first or after its last
year with a value. Only positive values are used, and
[`plot_bar()`](https://sedzinfo.github.io/golemworldbank/reference/plot_bar.md)
returns `NULL` when the indicator has fewer than two.

The values on the bars come from
[`format_value()`](https://sedzinfo.github.io/golemworldbank/reference/format_value.md),
which you can use for labels of your own. It abbreviates numbers to 3
significant digits with k, M, B and T:

``` r

format_value(c(0.0752, 950, 1520, 6020000, -5720000000, 29200000000000))
#> [1] "0.0752" "950"    "1.52k"  "6.02M"  "-5.72B" "29.2T"
```

## Bubble chart

[`plot_cor()`](https://sedzinfo.github.io/golemworldbank/reference/plot_cor.md)
draws every country as a bubble at its values of two indicators:
`indicator1` on the x axis and `indicator2` on the y axis. The size of a
bubble is the population of the country and its color is the region,
which comes from `country_code`. Hover over a bubble for its country and
region.

The legend of the regions is wide, and on a page as narrow as this one
it leaves little room for the bubbles, so here `plotly::layout()` moves
it above the chart. In a wide window,
[`plot_cor()`](https://sedzinfo.github.io/golemworldbank/reference/plot_cor.md)
alone is enough.

``` r

plot_cor(
  mfi_table(),
  country_code,
  indicator1 = "Mortality rate, adult, male (per 1,000 male adults)",
  indicator2 = "Mortality rate, infant (per 1,000 live births)",
  font_style = list(size = 12)
) %>%
  plotly::layout(legend = list(orientation = "h", y = 1.02, yanchor = "bottom"))
```

A country is in a year’s frame only when it has both values and its
population in that year. Its region is found by matching its name to the
`Short Name` of `country_code`, so a country whose name differs there is
left out. A click on a region in the legend hides or shows its bubbles,
and they stay hidden while the years play.

## Map

[`plot_map()`](https://sedzinfo.github.io/golemworldbank/reference/plot_map.md)
colors every country of a world map by the value of one indicator. The
countries are placed by their three-letter `Country Code`:

``` r

plot_map(
  mfi = mfi_table(),
  indicator = "Population, total",
  font_style = list(size = 12)
)
```

All the years share one color scale, from the lowest to the highest
value of any year, so the colors of two years can be compared.

## Your own animated charts

The Pause and Stop buttons come from
[`animation_buttons()`](https://sedzinfo.github.io/golemworldbank/reference/animation_buttons.md),
and the legend clicks that last while the years play from
[`keep_legend_clicks()`](https://sedzinfo.github.io/golemworldbank/reference/keep_legend_clicks.md).
Both work on any animated plotly chart. Give
[`animation_buttons()`](https://sedzinfo.github.io/golemworldbank/reference/animation_buttons.md)
the name of the first frame, which Stop goes back to:

``` r

d <- data.frame(x = 1:3, y = c(2, 4, 3), year = c("1960", "1961", "1962"))
p <- plotly::plot_ly(d, x = ~x, y = ~y, frame = ~year,
                     type = "scatter", mode = "markers")
p <- plotly::layout(p, updatemenus = animation_buttons("1960"))
keep_legend_clicks(p)
```

Like the line charts, the animated charts are plotly objects, so
[`htmlwidgets::saveWidget()`](https://rdrr.io/pkg/htmlwidgets/man/saveWidget.html)
saves any of them as a web page:

``` r

map <- plot_map(mfi_table(), "Population, total", font_style)
htmlwidgets::saveWidget(map, "map.html")
```
