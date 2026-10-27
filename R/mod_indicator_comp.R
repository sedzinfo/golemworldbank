##########################################################################################
#
##########################################################################################
#' @title Indicator Comparison tab - UI
#' @description A picker for one or more indicators, one for the country, and the line
#' chart of [plot_indicator_comp()].
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_indicator_comp_ui("indicator_comp"))
#' }
mod_indicator_comp_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectizeInput(ns("multiple_indicator_comp"),
      label = "Indicator",
      choices = c("Population, female", "Population, male"),
      selected = c("Population, female", "Population, male"),
      multiple = TRUE,
      width = "100%"
    ),
    selectizeInput(ns("country_indicator_comp"),
      label = "Country",
      choices = sort(unique(mfi$`Country Name`)),
      selected = c("Greece"),
      width = "100%"
    ),
    plotly::plotlyOutput(ns("plot_indicator_comp"), width = "100%", height = "100%")
  )
}
##########################################################################################
#
##########################################################################################
#' @title Indicator Comparison tab - server
#' @description Whenever the country changes, offers only the indicators that have a
#' value for it (keeping the chosen ones), and draws [plot_indicator_comp()].
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_indicator_comp_ui()].
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns).
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_indicator_comp_server("indicator_comp", mfi)
#' }
#' }
mod_indicator_comp_server <- function(id, mfi) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$country_indicator_comp, {
      temp_choice <- mfi[mfi$`Country Name` %in% input$country_indicator_comp, ]
      updateSelectizeInput(session,
        inputId = "multiple_indicator_comp",
        choices = unique(temp_choice[complete.cases(temp_choice), "Indicator Name"]),
        selected = input$multiple_indicator_comp,
        server = TRUE
      )
    })

    output$plot_indicator_comp <- plotly::renderPlotly({
      req(input$country_indicator_comp, input$multiple_indicator_comp, cancelOutput = TRUE)
      plot_indicator_comp(mfi, input$country_indicator_comp, input$multiple_indicator_comp, font_style)
    })
  })
}
