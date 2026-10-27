# World Bank indicator values

The values of the World Development Indicators in long format, one row
per country, indicator and year: 217 countries, 1,497 indicators, the
years 1960 to 2025. Regions and income groups (such as "World") are not
included, and neither are missing values. This is the data of every tab
except the Pyramid.

## Usage

``` r
mfi
```

## Format

A data frame with 7,505,749 rows and 5 columns:

- Country Code:

  Three-letter World Bank code of the country, e.g. "GRC".

- Country Name:

  Country name, e.g. "Greece".

- Indicator Name:

  Indicator name, e.g. "Population, total".

- Year:

  Year of observation (factor).

- value:

  Value of the indicator for that country and year.

## Source

World Bank Open Data (<https://data.worldbank.org>).

## Examples

``` r
# \donttest{
head(mfi)
#>   Country Code Country Name                                                Indicator Name Year       value
#> 1          ABW        Aruba            Population ages 40-44, male (% of male population) 1960   4.7785742
#> 2          ABW        Aruba        Population ages 40-44, female (% of female population) 1960   4.8538127
#> 3          ABW        Aruba            Population ages 75-79, male (% of male population) 1960   0.3963624
#> 4          ABW        Aruba Population ages 80 and above, female (% of female population) 1960   0.4601364
#> 5          ABW        Aruba          Population ages 65 and above (% of total population) 1960   2.8558683
#> 6          ABW        Aruba                          Population ages 65 and above, female 1960 934.0000000
# }
```
