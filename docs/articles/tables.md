# Changes and the indicator index

The Change (%) tab of the [golemworldbank
app](https://sedzinfo.shinyapps.io/golemworldbank/) lists the indicators
that rose and fell for a country between two years, and the Index tab
lists every indicator with its definition. In R,
[`indicator_change()`](https://sedzinfo.github.io/golemworldbank/reference/indicator_change.md)
makes the comparison,
[`render_change_table()`](https://sedzinfo.github.io/golemworldbank/reference/render_change_table.md)
shows its tables and
[`render_index_table()`](https://sedzinfo.github.io/golemworldbank/reference/render_index_table.md)
shows the index. The tables are [DT](https://rstudio.github.io/DT/)
tables, which can be searched and sorted.

``` r

library(golemworldbank)
```

## What changed between two years

[`indicator_change()`](https://sedzinfo.github.io/golemworldbank/reference/indicator_change.md)
compares every indicator that a country has a value for in both years.
The percent change is `(value2 - value1) / |value1| * 100`, the change
relative to the value of the first year:

``` r

res <- indicator_change(mfi_table(), country = "Greece", year1 = 2000, year2 = 2020)
nrow(res$increased)
#> [1] 388
nrow(res$decreased)
#> [1] 368
```

`res$increased` and `res$decreased` have a row per indicator, with its
values in the two years, the change and the percent change, the largest
change first. Indicators that did not change are in neither. When the
country has no data in either year,
[`indicator_change()`](https://sedzinfo.github.io/golemworldbank/reference/indicator_change.md)
stops with an error.

Some indicators are left out of both, because their percent change says
little:

- The rates of change, such as “GDP growth (annual %)” or “Inflation,
  consumer prices (annual %)”, whose names contain “annual %”, “%
  change” or “growth”. A percent change of a growth rate means little.
  `include_rates = TRUE` keeps them.
- The indicators whose value changed sign, such as net inflows that went
  from -8 million to +6.7 billion, which would read as +82,000%.
  `include_sign_change = TRUE` keeps them, and `res$sign_change` lists
  them either way.
- The indicators whose value was 0 in the first year, where the percent
  change is not defined. `res$zero_base` lists them.

``` r

res$sign_change
#> [1] "Discrepancy in expenditure estimate of GDP (current LCU)"  "Foreign direct investment, net (BoP, current US$)"         "Foreign direct investment, net inflows (% of GDP)"        
#> [4] "Foreign direct investment, net inflows (BoP, current US$)" "Net errors and omissions (BoP, current US$)"               "Portfolio equity, net inflows (BoP, current US$)"         
#> [7] "Portfolio investment, net (BoP, current US$)"
res$zero_base
#> [1] "Cause of death, by other COVID-19 pandemic-related outcomes (% of total)" "Discrepancy in expenditure estimate of GDP (constant LCU)"               
#> [3] "Electricity production from nuclear sources (% of total)"
```

For an indicator that is itself a percentage, such as “Urban population
(% of total population)”, the percent change is relative to the old
percentage. It is not the difference in percentage points, which is the
`Change` column.

## Change tables

[`render_change_table()`](https://sedzinfo.github.io/golemworldbank/reference/render_change_table.md)
shows one of the two tables. The values and the change are shown to 3
significant digits, such as 6.02M, while sorting still uses the full
numbers. The percent change is in bold, green for an increase and red
for a decrease. The tables are long, so here they show only their first
10 rows, the largest changes:

``` r

render_change_table(head(res$increased, 10))
```

``` r

render_change_table(head(res$decreased, 10))
```

`render_change_table(res$increased)` shows the whole table on one long
page, as the app does.

## The indicator index

[`render_index_table()`](https://sedzinfo.github.io/golemworldbank/reference/render_index_table.md)
lists the indicators of the data you give it, in the order they first
appear there, with their World Bank topic and definition from
`indicator_info`. The Index tab gives it the whole of
[`mfi_table()`](https://sedzinfo.github.io/golemworldbank/reference/mfi_table.md),
which lists all 1,497 indicators on one long page:

``` r

render_index_table(mfi_table(), indicator_info)
```

Here it gets only the rows of the indicators whose names start with “GDP
per capita”:

``` r

per_capita <- subset(mfi_table(), startsWith(`Indicator Name`, "GDP per capita"))
render_index_table(per_capita, indicator_info)
```

## Save a table

[`htmlwidgets::saveWidget()`](https://rdrr.io/pkg/htmlwidgets/man/saveWidget.html)
saves any of the tables as a web page:

``` r

htmlwidgets::saveWidget(render_change_table(res$increased), "increased.html")
```
