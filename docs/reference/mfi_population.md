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
#>   Country Name                                                Indicator Name Year     value   age    unit    sex
#> 1        Aruba            Population ages 40-44, male (% of male population) 1960 4.7785742 40-44 Percent   Male
#> 2        Aruba        Population ages 40-44, female (% of female population) 1960 4.8538127 40-44 Percent Female
#> 3        Aruba            Population ages 75-79, male (% of male population) 1960 0.3963624 75-79 Percent   Male
#> 4        Aruba Population ages 80 and above, female (% of female population) 1960 0.4601364   80+ Percent Female
#> 5        Aruba     Population ages 80 and above, male (% of male population) 1960 0.2704154   80+ Percent   Male
#> 6        Aruba            Population ages 60-64, male (% of male population) 1960 1.6780575 60-64 Percent   Male
# }
```
