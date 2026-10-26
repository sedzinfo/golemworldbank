# Format a large number with a magnitude suffix

Abbreviates a numeric value using Tn/Bn/M/K suffixes (trillions,
billions, millions, thousands), rounding to the nearest whole unit.
Values under 1,000 are returned as-is (coerced to character).

## Usage

``` r
format_bignum(n)
```

## Arguments

- n:

  Numeric vector of values to format.

## Value

A character vector of formatted values.

## Examples

``` r
format_bignum(c(950, 1500, 2500000, 3200000000, 4100000000000))
#> [1] "950"  "2 K"  "2 M"  "3 Bn" "4 Tn"
#> [1] "950" "2 K" "2 M" "3 Bn" "4 Tn"
```
