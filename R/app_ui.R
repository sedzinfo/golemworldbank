#' The application User-Interface
#'
#' Defines the top-level navbar layout, with one tab per Shiny module.
#'
#' @param request Internal parameter for `{shiny}`. DO NOT REMOVE.
#'
#' @import shiny
#' @noRd
#'
#' @examples
#' \dontrun{
#' shiny::shinyApp(ui = app_ui, server = app_server)
#' }
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # compact navbar (outside navbarPage, which expects only tabs)
    tags$head(
      tags$style(HTML('.navbar-nav > li > a, .navbar-brand {
        padding-top:4px;
        padding-bottom:4px;
        height: 25px;
        }
        .navbar {min-height:20px;}
        /* plots fill the space left under the navbar and inputs */
        body {display:flex; flex-direction:column; height:100vh; margin:0;}
        body > .container-fluid {flex:1; width:100%;min-height:0; display:flex; flex-direction:column;}
        .tab-content {flex:1; min-height:0; display:flex;}
        .tab-content > .tab-pane.active {flex:1; min-width:0; min-height:0; display:flex; flex-direction:column; overflow:auto;}
        .tab-pane .plotly.html-widget-output {flex:1 1 0; min-height:300px;}'))
    ),
    # Application UI logic
    navbarPage(
      title = "Data: World Bank",
      collapsible = TRUE,
      fluid = TRUE,
      windowTitle = "Worldbank",
      tabPanel(title = "Country Comparison", mod_country_comp_ui("country_comp")),
      tabPanel(title = "Indicator Comparison", mod_indicator_comp_ui("indicator_comp")),
      tabPanel(title = "Pyramid", mod_pyramid_ui("pyramid")),
      tabPanel(title = "Barplot", mod_bar_ui("bar")),
      tabPanel(title = "Scatterplot", mod_scatter_ui("scatter")),
      tabPanel(title = "Map", mod_map_ui("map")),
      tabPanel(title = "Change (%)", mod_change_ui("change")),
      tabPanel(title = "Index", mod_index_table_ui("index_table"))
    )
  )
}

#' Add external resources to the application
#'
#' Internally used to add JS/CSS/favicon resources inside the Shiny
#' application.
#'
#' @import shiny
#' @importFrom golem add_resource_path favicon bundle_resources
#' @noRd
#'
#' @examples
#' \dontrun{
#' # called from inside app_ui():
#' shiny::tagList(golem_add_external_resources(), shiny::fluidPage())
#' }
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "golemworldbank"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
