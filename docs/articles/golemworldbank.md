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

[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"golemworldbank"``,`` `` repos ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"https://sedzinfo.r-universe.dev"``, ``"https://cloud.r-project.org"``)``)`

[`library`](https://rdrr.io/r/base/library.html)`(`[`golemworldbank`](https://sedzinfo.github.io/golemworldbank/)`)`

[`run_app()`](https://sedzinfo.github.io/golemworldbank/reference/run_app.md)
starts the app itself on your computer:

[`run_app`](https://sedzinfo.github.io/golemworldbank/reference/run_app.md)`(``)`

## The data

The data comes with the package: the World Development Indicators of
[World Bank Open Data](https://data.worldbank.org).
[`mfi_table()`](https://sedzinfo.github.io/golemworldbank/reference/mfi_table.md)
gives the values of the indicators, a row per country, indicator and
year: 217 countries, 1,497 indicators and the years 1960 to 2025.
Missing values are not in it, and neither are regions and income groups
such as “World”. For example, the last years of the population of
Greece:

`greece`` ``<-`` `[`subset`](https://rdrr.io/r/base/subset.html)`(`[`mfi_table`](https://sedzinfo.github.io/golemworldbank/reference/mfi_table.md)`(``)``, ``` `Country Name` ``` ``==`` ``"Greece"`` ``&`` `` ``` `Indicator Name` ``` ``==`` ``"Population, total"``)`` `[`tail`](https://rdrr.io/r/utils/head.html)`(``greece``)`` ``#> Country Code Country Name Indicator Name Year value`` ``#> 6675414 GRC Greece Population, total 2020 10698599`` ``#> 6856141 GRC Greece Population, total 2021 10570130`` ``#> 7028682 GRC Greece Population, total 2022 10437805`` ``#> 7192041 GRC Greece Population, total 2023 10407351`` ``#> 7340692 GRC Greece Population, total 2024 10405134`` ``#> 7454480 GRC Greece Population, total 2025 10413962`

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

`countries`` ``<-`` `[`sort`](https://rdrr.io/r/base/sort.html)`(`[`unique`](https://rdrr.io/r/base/unique.html)`(`[`mfi_table`](https://sedzinfo.github.io/golemworldbank/reference/mfi_table.md)`(``)``$``` `Country Name` ```)``)`` `[`writeLines`](https://rdrr.io/r/base/writeLines.html)`(`[`head`](https://rdrr.io/r/utils/head.html)`(``countries``)``)`` ``#> Afghanistan`` ``#> Albania`` ``#> Algeria`` ``#> American Samoa`` ``#> Andorra`` ``#> Angola`` ``indicators`` ``<-`` `[`unique`](https://rdrr.io/r/base/unique.html)`(`[`mfi_table`](https://sedzinfo.github.io/golemworldbank/reference/mfi_table.md)`(``)``$``` `Indicator Name` ```)`` `[`writeLines`](https://rdrr.io/r/base/writeLines.html)`(`[`grep`](https://rdrr.io/r/base/grep.html)`(``"^GDP per capita"``, ``indicators``, value ``=`` ``TRUE``)``)`` ``#> GDP per capita (constant 2015 US$)`` ``#> GDP per capita (constant LCU)`` ``#> GDP per capita (current LCU)`` ``#> GDP per capita (current US$)`` ``#> GDP per capita growth (annual %)`` ``#> GDP per capita, PPP (constant 2021 international $)`` ``#> GDP per capita, PPP (current international $)`

`indicator_info` gives the topic and definition of an indicator:

`info`` ``<-`` ``indicator_info``[``indicator_info``$``` `Indicator Name` ``` ``==`` ``"Population, total"``, ``]`` ``info``$``Topic`` ``#> [1] "Health: Population: Structure"`` `[`writeLines`](https://rdrr.io/r/base/writeLines.html)`(`[`strwrap`](https://rdrr.io/r/base/strwrap.html)`(``info``$``Definition``, ``70``)``)`` ``#> Total population is based on the de facto definition of population,`` ``#> which counts all residents regardless of legal status or citizenship.`` ``#> The values shown are midyear estimates.`

[Changes and the indicator
index](https://sedzinfo.github.io/golemworldbank/articles/tables.md)
shows the definitions in a table that can be searched.

## Compare countries

[`plot_country_comp()`](https://sedzinfo.github.io/golemworldbank/reference/plot_country_comp.md)
draws one indicator over the years, with a line per country, as the
Country Comparison tab does. Hover over a point for its country,
indicator, year and value:

[`plot_country_comp`](https://sedzinfo.github.io/golemworldbank/reference/plot_country_comp.md)`(`` `` `[`mfi_table`](https://sedzinfo.github.io/golemworldbank/reference/mfi_table.md)`(``)``,`` `` countries ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"Greece"``, ``"Bulgaria"``)``,`` `` indicator ``=`` ``"Population, total"``,`` `` font_style ``=`` ``font_style`` ``)`

A click on a country in the legend hides or shows its line.

## Compare indicators

[`plot_indicator_comp()`](https://sedzinfo.github.io/golemworldbank/reference/plot_indicator_comp.md)
draws several indicators of one country, with a line per indicator, as
the Indicator Comparison tab does. The indicators share one y axis, so
they compare well only when they have the same unit and a similar scale,
such as the female and the male population:

[`plot_indicator_comp`](https://sedzinfo.github.io/golemworldbank/reference/plot_indicator_comp.md)`(`` `` `[`mfi_table`](https://sedzinfo.github.io/golemworldbank/reference/mfi_table.md)`(``)``,`` `` country ``=`` ``"Greece"``,`` `` indicators ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"Population, female"``, ``"Population, male"``)``,`` `` font_style ``=`` ``font_style`` ``)`

## The font

Every chart takes a `font_style`: the font of its text, which goes to
`plotly::layout(font = )`. `font_style`, which comes with the package,
is the font of the app: 20 px, bold and dark gray. For another font,
pass a list of your own, such as a smaller size:

[`plot_country_comp`](https://sedzinfo.github.io/golemworldbank/reference/plot_country_comp.md)`(`` `` `[`mfi_table`](https://sedzinfo.github.io/golemworldbank/reference/mfi_table.md)`(``)``,`` `` countries ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"Greece"``, ``"Bulgaria"``, ``"Romania"``)``,`` `` indicator ``=`` ``"GDP per capita (current US$)"``,`` `` font_style ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``size ``=`` ``12``)`` ``)`

## Save or change a chart

The charts are plotly objects, so the functions of the plotly and
htmlwidgets packages work on them. To save a chart as a web page that
opens in any browser:

`chart`` ``<-`` `[`plot_country_comp`](https://sedzinfo.github.io/golemworldbank/reference/plot_country_comp.md)`(`` `` `[`mfi_table`](https://sedzinfo.github.io/golemworldbank/reference/mfi_table.md)`(``)``,`` `` countries ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"Greece"``, ``"Bulgaria"``)``,`` `` indicator ``=`` ``"Population, total"``,`` `` font_style ``=`` ``font_style`` ``)`` ``htmlwidgets``::`[`saveWidget`](https://rdrr.io/pkg/htmlwidgets/man/saveWidget.html)`(``chart``, ``"population.html"``)`

To change the layout, for example the title:

`plotly``::``layout``(``chart``, title ``=`` ``"Population of Greece and Bulgaria"``)`

The package exports the pipe `%>%`, so the changes can also be chained:

`chart`` `[`%>%`](https://sedzinfo.github.io/golemworldbank/reference/pipe.md)` `` ``plotly``::``layout``(``title ``=`` ``"Population of Greece and Bulgaria"``)`` `[`%>%`](https://sedzinfo.github.io/golemworldbank/reference/pipe.md)` `` ``htmlwidgets``::`[`saveWidget`](https://rdrr.io/pkg/htmlwidgets/man/saveWidget.html)`(``"population.html"``)`
