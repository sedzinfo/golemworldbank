# World Bank indicator values, with the names as text

The values of the World Development Indicators in long format, one row
per country, indicator and year:
[mfi](https://sedzinfo.github.io/golemworldbank/reference/mfi.md) with
the names of its countries and indicators as text. The package stores
[mfi](https://sedzinfo.github.io/golemworldbank/reference/mfi.md) with
these names as codes (factors), which keeps its file small enough for
GitHub without Git LFS and quick to load; this turns them back into text
the first time it is called, and keeps the table in memory for the next
calls. This is the data of every tab of the app except the Pyramid.

## Usage

``` r
mfi_table()
```

## Value

A data frame with 5 columns: `Country Code`, `Country Name` and
`Indicator Name` (character), `Year` (factor) and `value`.

## Examples

``` r
head(mfi_table())
#>   Country Code Country Name                                                Indicator Name Year       value
#> 1          ABW        Aruba            Population ages 40-44, male (% of male population) 1960   4.7785742
#> 2          ABW        Aruba        Population ages 40-44, female (% of female population) 1960   4.8538127
#> 3          ABW        Aruba            Population ages 75-79, male (% of male population) 1960   0.3963624
#> 4          ABW        Aruba Population ages 80 and above, female (% of female population) 1960   0.4601364
#> 5          ABW        Aruba          Population ages 65 and above (% of total population) 1960   2.8558683
#> 6          ABW        Aruba                          Population ages 65 and above, female 1960 934.0000000
```
