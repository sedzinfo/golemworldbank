# Indicators that rose or fell between two years for one country

Compares every indicator a country has a value for in both years, for
the Change (%) tab, and splits them into two tables: the ones that
increased from `year1` to `year2` and the ones that decreased, each
sorted by percent change (largest change first). The percent change is
`(value2 - value1) / |value1| * 100`; it is undefined when the `year1`
value is 0, so those indicators are left out of both tables (their names
are kept in the `zero_base` element). Indicators that did not change are
in neither table.

Rates of change ("annual %", "% change", "growth", e.g. "GDP growth
(annual %)", "Inflation, consumer prices (annual %)", "... (% change
from 1990)") are left out by default: a percent change of a growth rate
is not meaningful (a rate going from -0.01 to 1.7 reads as +17,000%).
`include_rates = TRUE` keeps them.

For indicators that are themselves percentages (e.g. "Urban population
(% of total population)") the percent change is relative to the old
percentage, not a difference in percentage points; the `Change` column
gives the plain difference.

## Usage

``` r
indicator_change(
  mfi,
  country,
  year1,
  year2,
  include_rates = FALSE,
  include_sign_change = FALSE
)
```

## Arguments

- mfi:

  Data frame of World Bank indicator values (long format, with
  `Country Name`, `Indicator Name`, `Year`, `value` columns).

- country:

  Character. Country name, as in `Country Name`.

- year1, year2:

  Numeric or character. The two years to compare.

- include_rates:

  Logical. Keep the rate-of-change indicators (names containing "annual
  %", "% change" or "growth"); `FALSE` (default) leaves them out.

- include_sign_change:

  Logical. Keep indicators whose value changed sign between the two
  years (e.g. net FDI inflows from -8 million to +6.7 billion): their
  percent change is not meaningful (+82,000%). `FALSE` (default) leaves
  them out; either way they are listed in `sign_change`.

## Value

A list with `increased` and `decreased` (data frames with the columns
`Indicator`, one named after each year with its value, `Change` and
`Change %`), `zero_base` (indicators left out because their `year1`
value is 0) and `sign_change` (indicators whose value changed sign; left
out of the tables unless `include_sign_change = TRUE`). Stops with an
error when the country has no data in either year.

## Examples

``` r
res <- indicator_change(mfi, country = "Greece", year1 = 2000, year2 = 2020)
head(res$increased)
#>                                                                             Indicator         2000         2020       Change Change %
#> 1     International tourism, expenditures for passenger transport items (current US$) 6.000000e+06 6.020000e+08 5.960000e+08  9933.33
#> 2                                                     Children out of school, primary 4.740000e+02 2.396600e+04 2.349200e+04  4956.12
#> 3                                    Children out of school (% of primary school age) 7.517000e-02 3.727260e+00 3.652090e+00  4858.44
#> 4 Electricity production from renewable sources, excluding hydroelectric (% of total) 8.376205e-01 2.945185e+01 2.861423e+01  3416.13
#> 5        Electricity production from renewable sources, excluding hydroelectric (kWh) 4.510000e+08 1.421081e+10 1.375981e+10  3050.96
#> 6         International tourism, receipts for passenger transport items (current US$) 4.300000e+07 1.178000e+09 1.135000e+09  2639.53
head(res$decreased)
#>                                                            Indicator          2000          2020        Change Change %
#> 1                  Net lending (+) / net borrowing (-) (current LCU) -5.720000e+09 -1.612600e+10 -1.040600e+10  -181.92
#> 2 Carbon dioxide (CO2) net fluxes from LULUCF - Other Land (Mt CO2e) -1.258600e+00 -3.237100e+00 -1.978500e+00  -157.20
#> 3                     Net lending (+) / net borrowing (-) (% of GDP) -4.200904e+00 -9.625192e+00 -5.424288e+00  -129.12
#> 4                        Fossil fuel energy consumption (% of total)  9.438860e+01  0.000000e+00 -9.438860e+01  -100.00
#> 5                People practicing open defecation (% of population)  5.191913e-01  0.000000e+00 -5.191913e-01  -100.00
#> 6   People practicing open defecation, rural (% of rural population)  1.439888e+00  0.000000e+00 -1.439888e+00  -100.00
```
