##########################################################################################
# 
##########################################################################################
#' @title The application server-side logic
#' @description Starts the server of each tab's module, giving it the packaged datasets
#' it needs ([mfi], [mfi_population], [country_code], [indicator_info]).
#' @param input,output,session Internal parameters for `{shiny}`.
#'   DO NOT REMOVE.
#' @noRd
#' @examples
#' \dontrun{
#' shiny::shinyApp(ui = app_ui, server = app_server)
#' }
app_server <- function(input, output, session) {
  # left from an earlier version: no script in the page sends input$dimension
  # or handles the scaleUI message, so this never runs
  mod_country_comp_server("country_comp", mfi)
  mod_indicator_comp_server("indicator_comp", mfi)
  mod_pyramid_server("pyramid", mfi_population)
  mod_bar_server("bar", mfi)
  mod_scatter_server("scatter", mfi, country_code)
  mod_map_server("map", mfi)
  mod_change_server("change", mfi)
  mod_index_table_server("index_table", mfi, indicator_info)
}
