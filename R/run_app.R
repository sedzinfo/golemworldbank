##########################################################################################
# 
##########################################################################################
#' Run the Shiny Application
#'
#' Launches the World Bank indicators explorer app.
#'
#' @param onStart See [shiny::shinyApp()].
#' @param options See [shiny::shinyApp()].
#' @param enableBookmarking See [shiny::shinyApp()].
#' @param uiPattern See [shiny::shinyApp()].
#' @param ... Arguments passed to [golem::with_golem_options()].
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
#'
#' @examples
#' \dontrun{
#' run_app()
#'
#' # override any shiny::shinyApp() option, e.g. to pick a fixed port:
#' run_app(options = list(port = 8080))
#' }
run_app <- function(
  onStart = NULL,
  options = list(),
  enableBookmarking = NULL,
  uiPattern = "/",
  ...
) {
  options(scipen = 999)
  with_golem_options(
    app = shinyApp(
      ui = app_ui,
      server = app_server,
      onStart = onStart,
      options = options,
      enableBookmarking = enableBookmarking,
      uiPattern = uiPattern
    ),
    golem_opts = list(...)
  )
}
