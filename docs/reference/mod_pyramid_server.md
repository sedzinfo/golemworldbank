# Population pyramid module - server

Renders the animated population pyramid for the country selected by the
user.

## Usage

``` r
mod_pyramid_server(id, mfi_population)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_pyramid_ui()`](https://sedzinfo.github.io/golemworldbank/reference/mod_pyramid_ui.md).

- mfi_population:

  Data frame of population-by-age/sex values (long format, with
  `Country Name`, `sex`, `age`, `Year`, `value` columns).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
# inside app_server():
function(input, output, session) {
  mod_pyramid_server("pyramid", mfi_population)
}
} # }
```
