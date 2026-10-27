# Format a large number with a magnitude suffix

Abbreviates numbers with the suffixes Tn, Bn, M and K (trillions,
billions, millions, thousands), rounded to a whole number of that unit,
so 1,500 becomes "2 K". Numbers under 1,000 are returned unchanged, as
text. For 3 significant digits ("1.52k"), as on the bars of the Barplot
tab, see the internal `format_value()`.

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
