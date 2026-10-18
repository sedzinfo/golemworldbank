# Population by age, sex, and country

Long-format population counts by five-year age group and sex, used to
drive the population pyramid module.

## Usage

``` r
mfi_population
```

## Format

A data frame with 458,304 rows and 7 columns:

- Country Name:

  Country name.

- Indicator Name:

  World Bank indicator name.

- Year:

  Year of observation (factor).

- value:

  Population count.

- age:

  Age group.

- unit:

  Unit of measurement.

- sex:

  "Male" or "Female".

## Source

World Bank Open Data (<https://data.worldbank.org>).

## Examples

``` r
# \donttest{
head(mfi_population)
#>   Country Name                                         Indicator Name Year    value   age    unit    sex
#> 1        Aruba Population ages 00-04, female (% of female population) 1960 14.57218 00-04 Percent Female
#> 2        Aruba     Population ages 00-04, male (% of male population) 1960 15.63224 00-04 Percent   Male
#> 3        Aruba Population ages 05-09, female (% of female population) 1960 14.28213 05-09 Percent Female
#> 4        Aruba     Population ages 05-09, male (% of male population) 1960 15.23402 05-09 Percent   Male
#> 5        Aruba Population ages 10-14, female (% of female population) 1960 12.57050 10-14 Percent Female
#> 6        Aruba     Population ages 10-14, male (% of male population) 1960 12.77065 10-14 Percent   Male
# }
```
