##########################################################################################
#
##########################################################################################
#' @title Map tab - UI
#' @description A picker for the indicator and the animated world map of [plot_map()].
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_map_ui("map"))
#' }
mod_map_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectizeInput(ns("indicator_map"),
      label = "",
      choices = "Population, total",
      selected = "Population, total",
      width = "100%"
    ),
    plotly::plotlyOutput(ns("plot_map"), width = "100%", height = "100%")
  )
}
##########################################################################################
#
##########################################################################################
#' @title Map tab - server
#' @description Fills the indicator picker with every indicator of `mfi` (on the server,
#' as the list is long) and draws [plot_map()] for the chosen one.
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_map_ui()].
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Code`, `Country Name`, `Indicator Name`, `Year`, `value`
#'   columns).
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_map_server("map", mfi)
#' }
#' }
mod_map_server <- function(id, mfi) {
  moduleServer(id, function(input, output, session) {
    updateSelectizeInput(session,
      inputId = "indicator_map",
      label = "",
      choices = sort(unique(mfi$`Indicator Name`)),
      selected = "Population, total",
      server = TRUE
    )

    output$plot_map <- plotly::renderPlotly({
      req(input$indicator_map, cancelOutput = TRUE)
      plot_map(mfi, input$indicator_map, font_style)
    })
  })
}
