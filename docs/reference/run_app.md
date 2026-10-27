# Run the World Bank Indicators Explorer

Builds the app: country and indicator comparisons over time, a
population pyramid, a bar chart race, a bubble scatter plot, a world
map, the indicators that changed between two years, and an index of the
indicators with their definitions. The app has a dark mode, switched by
the button at the right of the navbar.

It also sets `options(scipen = 999)`, so that R does not print numbers
in scientific notation; the option stays set after the app stops.

## Usage

``` r
run_app(
  analytics = FALSE,
  onStart = NULL,
  options = list(),
  enableBookmarking = NULL,
  uiPattern = "/",
  ...
)
```

## Arguments

- analytics:

  `TRUE` to add Google Analytics, through the cookie banner shared with
  the sites of sedzinfo.github.io, which loads it only after the visitor
  accepts. Meant for the public deployment (see `app.R`); off by
  default, so that running the app yourself sends nothing.

- onStart:

  See
  [`shiny::shinyApp()`](https://rdrr.io/pkg/shiny/man/shinyApp.html).

- options:

  See
  [`shiny::shinyApp()`](https://rdrr.io/pkg/shiny/man/shinyApp.html).

- enableBookmarking:

  See
  [`shiny::shinyApp()`](https://rdrr.io/pkg/shiny/man/shinyApp.html).

- uiPattern:

  See
  [`shiny::shinyApp()`](https://rdrr.io/pkg/shiny/man/shinyApp.html).

- ...:

  Options for the app, which its code reads with
  [`golem::get_golem_options()`](https://thinkr-open.github.io/golem/reference/get_golem_options.html);
  see
  [`golem::with_golem_options()`](https://thinkr-open.github.io/golem/reference/with_golem_options.html).

## Value

A Shiny app object. Printing it, as the console does, starts the app.

## Examples

``` r
if (FALSE) { # \dontrun{
run_app()

# override any shiny::shinyApp() option, e.g. to pick a fixed port:
run_app(options = list(port = 8080))
} # }
```
