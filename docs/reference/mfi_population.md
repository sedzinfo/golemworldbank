# Population by age group and sex

The share of each five-year age group in the male and in the female
population, per country and year: the 32 indicators of
[mfi](https://sedzinfo.github.io/golemworldbank/reference/mfi.md) such
as "Population ages 40-44, male (% of male population)", with their age
group and sex in columns of their own. This is the data of the Pyramid
tab.

## Usage

``` r
mfi_population
```

## Format

A data frame with 458,304 rows and 7 columns:

- Country Name:

  Country name.

- Indicator Name:

  Indicator name, as in
  [mfi](https://sedzinfo.github.io/golemworldbank/reference/mfi.md).

- Year:

  Year of observation (factor).

- value:

  Percent of the male or of the female population.

- age:

  Age group (factor, "00-04" to "80+").

- unit:

  Unit of `value`: always "Percent".

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
