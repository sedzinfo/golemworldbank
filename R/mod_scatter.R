##########################################################################################
# 
##########################################################################################
#' @title Scatterplot tab - UI
#' @description Pickers for the indicator of the x axis and of the y axis, and the
#' animated bubble chart of [plot_cor()].
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_scatter_ui("scatter"))
#' }
mod_scatter_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(5,
        selectizeInput(ns("indicator_cor1"),
          label = "",
          choices = NULL,
          selected = "Mortality rate, adult, male (per 1,000 male adults)",
          width = "100%"
        ),
        style = "display:inline-block"
      ),
      column(5,
        selectizeInput(ns("indicator_cor2"),
          label = "",
          choices = NULL,
          selected = "Mortality rate, infant (per 1,000 live births)",
          width = "100%"
        ),
        style = "display:inline-block"
      )
    ),
    plotly::plotlyOutput(ns("plot_cor"), width = "100%", height = "100%")
  )
}
##########################################################################################
# 
##########################################################################################
#' @title Scatterplot tab - server
#' @description Fills both indicator pickers with every indicator of `mfi` (on the
#' server, as the list is long) and draws [plot_cor()] for the chosen pair.
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_scatter_ui()].
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Indicator Name`, `Country Name`, `Year`, `value` columns).
#' @param country_code Data frame mapping countries to region, with columns
#'   `Country Code`, `Short Name`, `Region`, see [country_code].
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_scatter_server("scatter", mfi, country_code)
#' }
#' }
mod_scatter_server <- function(id, mfi, country_code) {
  moduleServer(id, function(input, output, session) {
    updateSelectizeInput(session,
      inputId = "indicator_cor1",
      label = "",
      choices = sort(unique(mfi$`Indicator Name`)),
      selected = "Mortality rate, adult, male (per 1,000 male adults)",
      server = TRUE
    )
    updateSelectizeInput(session,
      inputId = "indicator_cor2",
      label = "",
      choices = sort(unique(mfi$`Indicator Name`)),
      selected = "Mortality rate, infant (per 1,000 live births)",
      server = TRUE
    )

    output$plot_cor <- plotly::renderPlotly({
      req(input$indicator_cor1, input$indicator_cor2, cancelOutput = TRUE)
      plot_cor(mfi, country_code, input$indicator_cor1, input$indicator_cor2, font_style)
    })
  })
}
