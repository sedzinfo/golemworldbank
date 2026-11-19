# Indicator charts in R

The charts and tables of the [golemworldbank
app](https://sedzinfo.shinyapps.io/golemworldbank/) are also R
functions. They take the World Bank data that comes with the package and
return an interactive [plotly](https://plotly.com/r/) chart or a
[DT](https://rstudio.github.io/DT/) table. Run one in the console and it
opens in the RStudio Viewer or your browser. In an R Markdown or Quarto
document it appears in the page.

This article shows the data and the line charts of the Country
Comparison and Indicator Comparison tabs. [Animated
charts](https://sedzinfo.github.io/golemworldbank/articles/animated.md)
shows the population pyramid, the bar chart race, the bubble chart and
the map, and [Changes and the indicator
index](https://sedzinfo.github.io/golemworldbank/articles/tables.md)
shows the tables of the Change (%) and Index tabs.

## Install and load the package

``` r

install.packages("golemworldbank",
  repos = c("https://sedzinfo.r-universe.dev", "https://cloud.r-project.org"))
```

``` r

library(golemworldbank)
```

[`run_app()`](https://sedzinfo.github.io/golemworldbank/reference/run_app.md)
starts the app itself on your computer:

``` r

run_app()
```

## The data

The data comes with the package: the World Development Indicators of
[World Bank Open Data](https://data.worldbank.org).
[`mfi_table()`](https://sedzinfo.github.io/golemworldbank/reference/mfi_table.md)
gives the values of the indicators, a row per country, indicator and
year: 217 countries, 1,497 indicators and the years 1960 to 2025.
Missing values are not in it, and neither are regions and income groups
such as “World”. For example, the last years of the population of
Greece:

``` r

greece <- subset(mfi_table(), `Country Name` == "Greece" &
                   `Indicator Name` == "Population, total")
tail(greece)
#>         Country Code Country Name    Indicator Name Year    value
#> 6675414          GRC       Greece Population, total 2020 10698599
#> 6856141          GRC       Greece Population, total 2021 10570130
#> 7028682          GRC       Greece Population, total 2022 10437805
#> 7192041          GRC       Greece Population, total 2023 10407351
#> 7340692          GRC       Greece Population, total 2024 10405134
#> 7454480          GRC       Greece Population, total 2025 10413962
```

The package stores this table as the dataset `mfi`, with the names of
the countries and indicators as codes, which keeps its file small.
[`mfi_table()`](https://sedzinfo.github.io/golemworldbank/reference/mfi_table.md)
turns them back into text the first time it is called and keeps the
table in memory for the next calls, so the examples below call it in
every chart.

Three more datasets come with the package:

- `mfi_population`, the share of each five-year age group in the male
  and in the female population, per country and year, for the population
  pyramid;
- `country_code`, the World Bank’s metadata of each country, such as its
  region and income group, which give the bubble chart its colors;
- `indicator_info`, the World Bank’s topic and definition of every
  indicator.

## Find countries and indicators

The functions take the names of the countries and indicators as they are
in the data. To list them:

``` r

countries <- sort(unique(mfi_table()$`Country Name`))
head(countries)
#> [1] "Afghanistan"    "Albania"        "Algeria"        "American Samoa" "Andorra"        "Angola"
indicators <- unique(mfi_table()$`Indicator Name`)
grep("^GDP per capita", indicators, value = TRUE)
#> [1] "GDP per capita (constant 2015 US$)"                  "GDP per capita (constant LCU)"                       "GDP per capita (current LCU)"                       
#> [4] "GDP per capita (current US$)"                        "GDP per capita growth (annual %)"                    "GDP per capita, PPP (constant 2021 international $)"
#> [7] "GDP per capita, PPP (current international $)"
```

`indicator_info` gives the topic and definition of an indicator:

``` r

info <- indicator_info[indicator_info$`Indicator Name` == "Population, total", ]
info$Topic
#> [1] "Health: Population: Structure"
writeLines(strwrap(info$Definition, 70))
#> Total population is based on the de facto definition of population,
#> which counts all residents regardless of legal status or citizenship.
#> The values shown are midyear estimates.
```

[Changes and the indicator
index](https://sedzinfo.github.io/golemworldbank/articles/tables.md)
shows the definitions in a table that can be searched.

## Compare countries

[`plot_country_comp()`](https://sedzinfo.github.io/golemworldbank/reference/plot_country_comp.md)
draws one indicator over the years, with a line per country, as the
Country Comparison tab does. Hover over a point for its country,
indicator, year and value:

``` r

plot_country_comp(
  mfi_table(),
  countries = c("Greece", "Bulgaria"),
  indicator = "Population, total",
  font_style = font_style
)
```

A click on a country in the legend hides or shows its line.

## Compare indicators

[`plot_indicator_comp()`](https://sedzinfo.github.io/golemworldbank/reference/plot_indicator_comp.md)
draws several indicators of one country, with a line per indicator, as
the Indicator Comparison tab does. The indicators share one y axis, so
they compare well only when they have the same unit and a similar scale,
such as the female and the male population:

``` r

plot_indicator_comp(
  mfi_table(),
  country = "Greece",
  indicators = c("Population, female", "Population, male"),
  font_style = font_style
)
```

## The font

Every chart takes a `font_style`: the font of its text, which goes to
`plotly::layout(font = )`. `font_style`, which comes with the package,
is the font of the app: 20 px, bold and dark gray. For another font,
pass a list of your own, such as a smaller size:

``` r

plot_country_comp(
  mfi_table(),
  countries = c("Greece", "Bulgaria", "Romania"),
  indicator = "GDP per capita (current US$)",
  font_style = list(size = 12)
)
```

## Save or change a chart

The charts are plotly objects, so the functions of the plotly and
htmlwidgets packages work on them. To save a chart as a web page that
opens in any browser:

``` r

chart <- plot_country_comp(
  mfi_table(),
  countries = c("Greece", "Bulgaria"),
  indicator = "Population, total",
  font_style = font_style
)
htmlwidgets::saveWidget(chart, "population.html")
```

To change the layout, for example the title:

``` r

plotly::layout(chart, title = "Population of Greece and Bulgaria")
```

The package exports the pipe `%>%`, so the changes can also be chained:

``` r

chart %>%
  plotly::layout(title = "Population of Greece and Bulgaria") %>%
  htmlwidgets::saveWidget("population.html")
```
