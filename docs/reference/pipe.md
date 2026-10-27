# Pipe operator

Re-exported from dplyr, so that the code of the package and its users
can chain calls with it. See `magrittr::%>%` for details.

## Usage

``` r
lhs %>% rhs
```

## Arguments

- lhs:

  A value.

- rhs:

  A function call, which gets `lhs` as its first argument.

## Value

The result of the call `rhs` with `lhs` as its first argument.
