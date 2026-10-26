# Indicators that rose or fell between two years for one country

Compares every indicator a country has a value for in both years and
splits them into two tables: the ones that increased from `year1` to
`year2` and the ones that decreased, each sorted by percent change
(largest change first). Percent change is
`(value2 - value1) / |value1| * 100`; it is undefined when the `year1`
value is 0, so those indicators are left out of both tables (their names
are kept in the `zero_base` element). Indicators that did not change are
in neither table.

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
  them out and lists them in `sign_change`.

## Value

A list with `increased` and `decreased` (data frames with columns
`Indicator`, the two years' values, `Change` and `Change %`),
`zero_base` (indicators left out because their `year1` value is 0) and
`sign_change` (indicators whose value changed sign; left out unless
`include_sign_change = TRUE`).

## Details

Rates of change ("annual %", "% change", "growth", e.g. "GDP growth
(annual %)", "Inflation, consumer prices (annual %)", "... (% change
from 1990)") are left out by default: a percent change of a growth rate
is not meaningful (a rate going from -0.01 to 1.7 reads as +17,000%).
`include_rates = TRUE` keeps them.

For indicators that are themselves percentages (e.g. "Urban population
(% of total population)") the percent change is relative to the old
percentage, not a difference in percentage points; the `Change` column
gives the plain difference.

## Examples

``` r
res <- indicator_change(mfi, country = "Greece", year1 = 2024, year2 = 2025)
head(res$increased)
#>                                                    Indicator         2024         2025       Change Change %
#> 1 Foreign direct investment, net outflows (BoP, current US$) 2.219862e+09 5.957093e+09 3.737232e+09   168.35
#> 2         Foreign direct investment, net outflows (% of GDP) 8.663269e-01 2.122715e+00 1.256389e+00   145.02
#> 3                   Stocks traded, total value (current US$) 2.323616e+10 4.811845e+10 2.488229e+10   107.08
#> 4  Foreign direct investment, net inflows (BoP, current US$) 6.742277e+09 1.357470e+10 6.832427e+09   101.34
#> 5                      Stocks traded, total value (% of GDP) 9.068181e+00 1.714624e+01 8.078062e+00    89.08
#> 6          Foreign direct investment, net inflows (% of GDP) 2.631252e+00 4.837130e+00 2.205878e+00    83.83
head(res$decreased)
#>                                           Indicator        2024         2025      Change Change %
#> 1      Portfolio investment, net (BoP, current US$) -6325496155 -12777283277 -6451787122  -102.00
#> 2       Arms exports (SIPRI trend indicator values)    20000000      2000000   -18000000   -90.00
#> 3              Changes in inventories (current LCU)  5333733000    900044000 -4433689000   -83.13
#> 4              Changes in inventories (current US$)  5773128425   1017034543 -4756093882   -82.38
#> 5 Foreign direct investment, net (BoP, current US$) -4522415327  -7617610888 -3095195560   -68.44
#> 6  Asylum-seekers by country or territory of origin         233          121        -112   -48.07
```
