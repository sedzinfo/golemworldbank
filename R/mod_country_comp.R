##########################################################################################
#
##########################################################################################
#' @title Country Comparison tab - UI
#' @description A picker for one or more countries, one for the indicator, and the line
#' chart of [plot_country_comp()].
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_country_comp_ui("country_comp"))
#' }
mod_country_comp_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectizeInput(ns("multiple_country_comp"),
      label = "Country",
      choices = sort(unique(as.character(mfi$`Country Name`))),
      selected = c("Greece", "Bulgaria"),
      multiple = TRUE,
      width = "100%"
    ),
    selectizeInput(ns("indicator_country_comp"),
      label = "Indicator",
      choices = "Population, total",
      selected = "Population, total",
      width = "100%"
    ),
    plotly::plotlyOutput(ns("plot_country_comp"), width = "100%", height = "100%")
  )
}
##########################################################################################
#
##########################################################################################
#' @title Country Comparison tab - server
#' @description Whenever the countries change, offers only the indicators that have a
#' value for at least one of them (keeping the chosen indicator), and draws
#' [plot_country_comp()].
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_country_comp_ui()].
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns).
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_country_comp_server("country_comp", mfi)
#' }
#' }
mod_country_comp_server <- function(id, mfi) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$multiple_country_comp, {
      temp_choice <- mfi[mfi$`Country Name` %in% input$multiple_country_comp, ]
      updateSelectizeInput(session,
        inputId = "indicator_country_comp",
        choices = unique(temp_choice[complete.cases(temp_choice), "Indicator Name"]),
        selected = input$indicator_country_comp,
        server = TRUE
      )
    })

    output$plot_country_comp <- plotly::renderPlotly({
      req(input$multiple_country_comp, input$indicator_country_comp, cancelOutput = TRUE)
      plot_country_comp(mfi, input$multiple_country_comp, input$indicator_country_comp, font_style)
    })
  })
}
