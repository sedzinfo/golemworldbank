#' What changed module - UI
#'
#' Renders a country picker, two year pickers, the two noise filters of
#' [indicator_change()] and two tables (indicators that increased / decreased
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
    textOutput(ns("summary_change")),
    tabsetPanel(
      tabPanel("Increased", DT::dataTableOutput(ns("increased_change"))),
      tabPanel("Decreased", DT::dataTableOutput(ns("decreased_change")))
    )
  )
}

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
