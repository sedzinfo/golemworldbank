##########################################################################################
# 
##########################################################################################
#' Bar chart module - UI
#'
#' Renders an indicator picker and an animated ranked bar chart (races
#' countries by value, one animation frame per year).
#'
#' @param id Character. Module namespace id.
#'
#' @return A `tagList` of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_bar_ui("bar"))
#' }
mod_bar_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(column(5, selectizeInput(ns("indicator_bar"),
      label = NULL,
      choices = "GDP (current US$)",
      selected = "GDP (current US$)",
      width = "100%"
    )),
    column(2, selectInput(ns("top_n_bar"),
      label = NULL,
      choices = c("Top 10" = 10, "Top 20" = 20, "Top 30" = 30, "Top 50" = 50),
      selected = 20,
      width = "100%"
    ))),
    plotly::plotlyOutput(ns("plot_bar"), width = "100%", height = "95vh")
  )
}
##########################################################################################
# 
##########################################################################################
#' Bar chart module - server
#'
#' Populates the indicator choices from `mfi` and renders the animated bar
#' chart for the indicator selected by the user.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_bar_ui()].
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Indicator Name`, `Country Name`, `Year`, `value` columns).
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_bar_server("bar", mfi)
#' }
#' }
mod_bar_server <- function(id, mfi) {
  moduleServer(id, function(input, output, session) {
    updateSelectizeInput(session,
      inputId = "indicator_bar",
      label = "",
      choices = sort(unique(mfi$`Indicator Name`)),
      selected = "GDP (current US$)",
      server = TRUE
    )
    output$plot_bar <- plotly::renderPlotly({
      plot_bar(mfi, input$indicator_bar, font_style, top_n = as.integer(input$top_n_bar))
    })
  })
}
