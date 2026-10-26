#' The application server-side logic
#'
#' Rescales the UI in response to the client's `dimension` input, then wires
#' up each tab's Shiny module server against the packaged datasets ([mfi],
#' [mfi_population], [country_code]).
#'
#' @param input,output,session Internal parameters for `{shiny}`.
#'   DO NOT REMOVE.
#'
#' @noRd
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(ui = app_ui, server = app_server)
#' }
app_server <- function(input, output, session) {
  observeEvent(input$dimension, {
    w <- input$dimension[1]
    h <- input$dimension[2]

    base_w <- 1400
    base_h <- 900

    scale_w <- w / base_w
    scale_h <- h / base_h

    scale <- min(scale_w, scale_h, 1) # never upscale

    session$sendCustomMessage("scaleUI", scale)
  })

  mod_country_comp_server("country_comp", mfi)
  mod_indicator_comp_server("indicator_comp", mfi)
  mod_pyramid_server("pyramid", mfi_population)
  mod_bar_server("bar", mfi)
  mod_scatter_server("scatter", mfi, country_code)
  mod_map_server("map", mfi)
  mod_change_server("change", mfi)
  mod_index_table_server("index_table", mfi)
}
