# Google Analytics for the public deployment

Loads the cookie banner shared with the sites of sedzinfo.github.io,
which loads Google Analytics only after the visitor accepts. The script
that reports the tabs as pages (`inst/app/www/analytics.js`) and the
style of the banner (`analytics.css`) are always in the page, but send
nothing without the banner.

## Usage

``` r
analytics_resources()
```

## Value

A `script` tag for the head of the page.

## Examples

``` r
golemworldbank:::analytics_resources()
#> <script src="https://sedzinfo.github.io/consent.js" defer></script>
```
