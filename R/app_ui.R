##########################################################################################
#
##########################################################################################
#' @title The application User-Interface
#' @description A navbar page with one tab per module. The navbar is made compact, and
#' each tab fills the window under it: the charts stretch to the bottom of the
#' window, and a tab that is longer than the window scrolls by itself, under a
#' navbar that stays in place.
#' @param request Internal parameter for `{shiny}`. DO NOT REMOVE.
#' @param analytics `TRUE` to add Google Analytics, with its cookie banner
#'   (see `analytics_resources()`) and a footer with the links of the banner
#'   (see `analytics_footer()`).
#' @import shiny
#' @noRd
#' @examples
#' \dontrun{
#' shiny::shinyApp(ui = app_ui, server = app_server)
#' }
app_ui <- function(request, analytics = FALSE) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    if (analytics) tags$head(analytics_resources()),
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
        /* a Bootstrap row sticks out 15px on the right (margin-right:-15px), which would make the scrolling tab scroll sideways */
        .tab-pane > .row {margin-right:0;}
        .tab-pane .plotly.html-widget-output {flex:1 1 0; min-height:300px;}'))
    ),
    # Application UI logic
    navbarPage(
      title = "Data: World Bank",
      collapsible = TRUE,
      fluid = TRUE,
      windowTitle = "Worldbank",
      footer = if (analytics) analytics_footer(),
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

##########################################################################################
#
##########################################################################################
#' @title Add external resources to the application
#' @description Adds the favicon and every CSS and JS file of `inst/app/www` to the head
#' of the page: the analytics files (`analytics.css`, `analytics.js`) and the
#' dark mode (`dark_mode.css`, `dark_mode.js`). A file put in that folder is
#' added without any change here.
#' @return A `head` tag.
#' @import shiny
#' @importFrom golem add_resource_path favicon bundle_resources
#' @noRd
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
