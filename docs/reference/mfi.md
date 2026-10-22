# World Bank indicator values

Long-format World Bank development indicator values, one row per
country/indicator/year.

## Usage

``` r
mfi
```

## Format

A data frame with 7,478,197 rows and 5 columns:

- Country Code:

  ISO country code.

- Country Name:

  Country name.

- Indicator Name:

  World Bank indicator name.

- Year:

  Year of observation (factor).

- value:

  Indicator value for that country/year.

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
