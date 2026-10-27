##########################################################################################
# 
##########################################################################################
#' @title Run the World Bank Indicators Explorer
#' @description Builds the app: country and indicator comparisons over time, a population
#' pyramid, a bar chart race, a bubble scatter plot, a world map, the
#' indicators that changed between two years, and an index of the indicators
#' with their definitions. The app has a dark mode, switched by the button at
#' the right of the navbar.
#'
#' It also sets `options(scipen = 999)`, so that R does not print numbers in
#' scientific notation; the option stays set after the app stops.
#' @param analytics `TRUE` to add Google Analytics, through the cookie banner
#'   shared with the sites of sedzinfo.github.io, which loads it only after the
#'   visitor accepts. Meant for the public deployment (see `app.R`); off by
#'   default, so that running the app yourself sends nothing.
#' @param onStart See [shiny::shinyApp()].
#' @param options See [shiny::shinyApp()].
#' @param enableBookmarking See [shiny::shinyApp()].
#' @param uiPattern See [shiny::shinyApp()].
#' @param ... Options for the app, which its code reads with
#'   [golem::get_golem_options()]; see [golem::with_golem_options()].
#' @return A Shiny app object. Printing it, as the console does, starts the app.
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
#' @examples
#' \dontrun{
#' run_app()
#'
#' # override any shiny::shinyApp() option, e.g. to pick a fixed port:
#' run_app(options = list(port = 8080))
#' }
run_app <- function(
  analytics = FALSE,
  onStart = NULL,
  options = list(),
  enableBookmarking = NULL,
  uiPattern = "/",
  ...
) {
  options(scipen = 999)
  with_golem_options(
    app = shinyApp(
      # shiny calls the ui function with the request only, so analytics is passed in here
      ui = function(request) app_ui(request, analytics),
      server = app_server,
      onStart = onStart,
      options = options,
      enableBookmarking = enableBookmarking,
      uiPattern = uiPattern
    ),
    golem_opts = list(...)
  )
}
