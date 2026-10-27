##########################################################################################
# 
##########################################################################################
#' @title Pyramid tab - UI
#' @description A picker for the country and the animated population pyramid of
#' [plot_pyramid()].
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_pyramid_ui("pyramid"))
#' }
mod_pyramid_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectizeInput(ns("indicator_pyramid_country"),
      label = "",
      choices = sort(unique(mfi$`Country Name`)),
      selected = "Greece",
      width = "100%"
    ),
    plotly::plotlyOutput(ns("plot_pyramid"), width = "100%", height = "100%")
  )
}
##########################################################################################
# 
##########################################################################################
#' @title Pyramid tab - server
#' @description Draws [plot_pyramid()] for the chosen country.
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_pyramid_ui()].
#' @param mfi_population Data frame of population shares by age group and sex
#'   (long format, with `Country Name`, `sex`, `age`, `Year`, `value` columns),
#'   see [mfi_population].
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_pyramid_server("pyramid", mfi_population)
#' }
#' }
mod_pyramid_server <- function(id, mfi_population) {
  moduleServer(id, function(input, output, session) {
    output$plot_pyramid <- plotly::renderPlotly({
      plot_pyramid(mfi_population, input$indicator_pyramid_country, font_style)
    })
  })
}
