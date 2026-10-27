# Indicator topics and definitions

World Bank topic and definition of every indicator in
[mfi](https://sedzinfo.github.io/golemworldbank/reference/mfi.md), shown
in the Index tab.

## Usage

``` r
indicator_info
```

## Format

A data frame with 1,497 rows and 3 columns:

- Indicator Name:

  Indicator name, as in
  [mfi](https://sedzinfo.github.io/golemworldbank/reference/mfi.md).

- Topic:

  World Bank topic, e.g. "Health: Population: Structure".

- Definition:

  Short definition of the indicator.

## Source

World Bank Open Data (<https://data.worldbank.org>), WDISeries.csv.

## Examples

``` r
# \donttest{
head(indicator_info)
#>                                                                      Indicator Name                                Topic
#> 1              Access to clean fuels and technologies for cooking (% of population) Environment: Energy production & use
#> 2 Access to clean fuels and technologies for cooking, rural (% of rural population) Environment: Energy production & use
#> 3 Access to clean fuels and technologies for cooking, urban (% of urban population) Environment: Energy production & use
#> 4                                           Access to electricity (% of population) Environment: Energy production & use
#> 5                              Access to electricity, rural (% of rural population) Environment: Energy production & use
#> 6                              Access to electricity, urban (% of urban population) Environment: Energy production & use
#>                                                                                                                                                                                                                               Definition
#> 1        Access to clean fuels and technologies for cooking is the proportion of total population primarily using clean cooking fuels and technologies for cooking. Under WHO guidelines, kerosene is excluded from clean cooking fuels.
#> 2 Access to clean fuels and technologies for cooking, rural is the proportion of rural population primarily using clean cooking fuels and technologies for cooking. Under WHO guidelines, kerosene is excluded from clean cooking fuels.
#> 3 Access to clean fuels and technologies for cooking, urban is the proportion of urban population primarily using clean cooking fuels and technologies for cooking. Under WHO guidelines, kerosene is excluded from clean cooking fuels.
#> 4                                                        Access to electricity is the percentage of population with access to electricity. Electrification data are collected from industry, national surveys and international sources.
#> 5                                                                                                                                         Access to electricity, rural is the percentage of rural population with access to electricity.
#> 6                                                                                                                                         Access to electricity, urban is the percentage of urban population with access to electricity.
# }
```
