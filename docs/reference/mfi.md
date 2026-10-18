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
#>   Country Code Country Name                                                Indicator Name Year     value
#> 1          ABW        Aruba Adolescent fertility rate (births per 1,000 women ages 15-19) 1960 44.732000
#> 2          ABW        Aruba            Age dependency ratio (% of working-age population) 1960 83.046159
#> 3          ABW        Aruba       Age dependency ratio, old (% of working-age population) 1960  5.229128
#> 4          ABW        Aruba     Age dependency ratio, young (% of working-age population) 1960 77.817030
#> 5          ABW        Aruba                          Aquaculture production (metric tons) 1960  0.000000
#> 6          ABW        Aruba                          Birth rate, crude (per 1,000 people) 1960 32.043000
# }
```
