##########################################################################################
#
##########################################################################################
#' @title The application User-Interface
#' @description A navbar page with one tab per module. The navbar is made 
#' compact, and each tab fills the window under it: the charts stretch to the
#' bottom of the window, and a tab that is longer than the window scrolls by
#' itself, under a navbar that stays in place.
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
      tabPanel(title = "Choropleth", mod_map_ui("map")),
      tabPanel(title = "Change (%)", mod_change_ui("change")),
      tabPanel(title = "Index", mod_index_table_ui("index_table")),
      tabPanel(title = "About", mod_about_ui("about"))
    )
  )
}
##########################################################################################
#
##########################################################################################
#' @title Address and description of the live app, for search engines and link previews
#' @description Used by `golem_add_external_resources()` for the description
#' that search engines show and the Open Graph tags of the preview that other
#' sites show for a link to the app. `title` is the window title that `app_ui()`
#' gives the page, and `image` the first screenshot of the README.
#' @noRd
app_meta <- list(
  url = "https://sedzinfo.shinyapps.io/golemworldbank/",
  title = "Worldbank",
  description = "Explore World Bank development indicators with interactive country and indicator comparisons, population pyramids, bar charts, scatter plots and maps.",
  image = "https://raw.githubusercontent.com/sedzinfo/golemworldbank/main/man/figures/worldbank1.png"
)
##########################################################################################
#
##########################################################################################
#' @title Add external resources to the application
#' @description Adds the description and Open Graph tags of `app_meta`, the
#' favicon and every CSS and JS file of `inst/app/www` to
#' the head of the page, such as the style of the dark mode (`dark_mode.css`);
#' a file put in that folder is added without any change here. The script of
#' the dark mode (`dark_mode.js`) is shared by the apps: it comes from
#' sedzinfo.github.io (`shared_url`), as do the files of the analytics
#' (`analytics_resources()`).
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
  add_resource_path("www",app_sys("app/www"))
  tags$head(
    tags$meta(name = "description", content = app_meta$description),
    tags$meta(property = "og:type", content = "website"),
    tags$meta(property = "og:site_name", content = "sedzinfo"),
    tags$meta(property = "og:title", content = app_meta$title),
    tags$meta(property = "og:description", content = app_meta$description),
    tags$meta(property = "og:url", content = app_meta$url),
    tags$meta(property = "og:image", content = app_meta$image),
    tags$meta(name = "twitter:card", content = "summary_large_image"),
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "golemworldbank"
    ),
    tags$script(src = paste0(shared_url, "dark_mode.js"))
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
