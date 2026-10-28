# Format numbers compactly to 3 significant digits

Abbreviates numbers to 3 significant digits with the suffixes k, M, B
and T (thousands, millions, billions, trillions); negative and small
values keep their sign and digits (6.02M, 1.42B, 0.0752, -5.72B). Used
for the labels and the hover text of the bars in
[`plot_bar()`](https://sedzinfo.github.io/golemworldbank/reference/plot_bar.md).

## Usage

``` r
format_value(n)
```

## Arguments

- n:

  Numeric vector of values to format.

## Value

A character vector of formatted values.

## Examples

``` r
format_value(c(0.0752, 950, 1520, 6020000, -5720000000, 29200000000000))
#> [1] "0.0752" "950"    "1.52k"  "6.02M"  "-5.72B" "29.2T" 
#> [1] "0.0752" "950" "1.52k" "6.02M" "-5.72B" "29.2T"
```
