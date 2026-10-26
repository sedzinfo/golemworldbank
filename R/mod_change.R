##########################################################################################
# 
##########################################################################################
#' What changed module - UI
#'
#' Renders a country picker, two year pickers, the two noise filters of
#' [indicator_change()], a note that the comparison is automatic and needs
#' interpretation, and two tables (indicators that increased / decreased
#' between the two years).
#'
#' @param id Character. Module namespace id.
#'
#' @return A `tagList` of Shiny UI elements.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_change_ui("change"))
#' }
mod_change_ui <- function(id) {
  ns <- NS(id)
  years <- sort(unique(as.character(mfi$Year)), decreasing = TRUE)
  tagList(
    fluidRow(
      column(4, selectizeInput(ns("country_change"),
        label = "Country",
        choices = sort(unique(as.character(mfi$`Country Name`))),
        selected = "Greece",
        width = "100%"
      )),
      column(2, selectInput(ns("year1_change"), label = "From", choices = years, selected = "2000", width = "100%")),
      column(2, selectInput(ns("year2_change"), label = "To", choices = years, selected = "2020", width = "100%")),
      column(4,
        checkboxInput(ns("rates_change"), "Include growth rates (annual %, % change)", value = FALSE),
        checkboxInput(ns("sign_change"), "Include indicators that changed sign", value = FALSE)
      )
    ),
    # these tables are a mechanical comparison of two years, not an analysis
    tags$p(class = "text-muted small", style = "margin-bottom:6px;",
      tags$b("Note:"),
      "these tables are produced automatically by comparing the two selected years,",
      "and need interpretation. Change % is (To - From) / |From| x 100, the change",
      "relative to the starting value; for indicators that are already percentages",
      "(e.g. % of population) it is not the difference in percentage points, which is",
      "the Change column. A change can come from a data revision, a missing or",
      "estimated value, a change of method or of currency (e.g. drachma to euro) rather",
      "than a real change, and a large percent change from a small starting value can",
      "matter little. Check the indicator's definition and its full time series",
      "(Country Comparison tab) before drawing conclusions."
    ),
    textOutput(ns("summary_change")),
    tabsetPanel(
      tabPanel("Increased", DT::dataTableOutput(ns("increased_change"))),
      tabPanel("Decreased", DT::dataTableOutput(ns("decreased_change")))
    )
  )
}
##########################################################################################
# 
##########################################################################################
#' What changed module - server
#'
#' Runs [indicator_change()] for the selected country and years and renders
#' its two tables with [render_change_table()].
#'
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_change_ui()].
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns).
#'
#' @return None. Called for its side effect of registering the module server.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' # inside app_server():
#' function(input, output, session) {
#'   mod_change_server("change", mfi)
#' }
#' }
mod_change_server <- function(id, mfi) {
  moduleServer(id, function(input, output, session) {
    res <- reactive({
      req(input$country_change, input$year1_change, input$year2_change)
      validate(need(input$year1_change != input$year2_change, "Choose two different years."))
      tryCatch(
        indicator_change(mfi, input$country_change, input$year1_change, input$year2_change,
          include_rates = input$rates_change, include_sign_change = input$sign_change
        ),
        error = function(e) validate(need(FALSE, conditionMessage(e)))
      )
    })

    output$summary_change <- renderText({
      r <- res()
      paste0(nrow(r$increased), " indicators increased and ", nrow(r$decreased),
             " decreased from ", input$year1_change, " to ", input$year2_change,
             " (only indicators with a value in both years).")
    })
    output$increased_change <- DT::renderDataTable(render_change_table(res()$increased))
    output$decreased_change <- DT::renderDataTable(render_change_table(res()$decreased))
  })
}
