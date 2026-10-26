#' Indicator index table module - UI
#'
#' Renders a DataTable output listing all available indicators.
#'
#' @param id Character. Module namespace id.
#'
#' @return A `DT::dataTableOutput` Shiny UI element.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_index_table_ui("index_table"))
#' }
mod_index_table_ui <- function(id) {
  ns <- NS(id)
  DT::dataTableOutput(ns("index_table"))
}

#' Indicator index table module - server
#'
#' Renders the datatable listing every distinct indicator present in `mfi`,
#' with its topic and definition.
#'
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_index_table_ui()].
#' @param mfi Data frame of World Bank indicator values, with an
#'   `Indicator Name` column.
#' @param indicator_info Data frame of indicator topics and definitions (see
#'   [indicator_info]).
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_index_table_server("index_table", mfi, indicator_info)
#' }
#' }
mod_index_table_server <- function(id, mfi, indicator_info) {
  moduleServer(id, function(input, output, session) {
    output$index_table <- DT::renderDataTable({
      render_index_table(mfi, indicator_info)
    })
  })
}
