# Google Analytics for the public deployment

Loads the cookie banner shared with the sites of sedzinfo.github.io,
which loads Google Analytics only after the visitor accepts, and two
files shared by the apps: the style of the banner on Bootstrap 3, which
lacks most of the Bootstrap 5 classes of the banner (`analytics.css`),
and the script that reports the tabs as pages (`analytics.js`).

## Usage

``` r
analytics_resources()
```

## Value

A `tagList` for the head of the page.

## Examples

``` r
golemworldbank:::analytics_resources()
#> <script src="https://sedzinfo.github.io/consent.js" defer></script>
#> <link rel="stylesheet" href="https://sedzinfo.github.io/shiny/analytics.css"/>
#> <script src="https://sedzinfo.github.io/shiny/analytics.js"></script>
```
