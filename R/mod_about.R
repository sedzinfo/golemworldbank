##########################################################################################
#
##########################################################################################
#' @title About tab - UI
#' @description A static page: what the app shows, where the data comes from,
#' the acknowledgments, and the license and links of the package. It has no
#' inputs, so it has no module server.
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(mod_about_ui("about"))
#' }
mod_about_ui <- function(id) {
  ns <- NS(id)
  # .noWS: no space between a link and the punctuation after it
  link <- function(href, text) tags$a(href = href, target = "_blank", rel = "noopener", text, .noWS = "outside")
  div(
    id = ns("page"),
    # centred in the tab: auto side margins, and width 100% since the tab is a flex
    # column, where auto margins would otherwise shrink the page to its text
    style = "width: 100%; max-width: 860px; margin: 0 auto; padding: 1.5rem 1rem;",
    h2("About"),
    p(
      strong("golemworldbank"), " is an interactive application for exploring the development",
      " indicators of the World Bank: how one indicator changes over time across countries, how",
      " several indicators change for one country, population pyramids, ranked bar charts,",
      " scatterplots of two indicators, choropleth maps, the change between two years, and an",
      " index of every indicator with its definition."
    ),
    h3("Data"),
    p(
      "All the data comes from ", link("https://data.worldbank.org", "World Bank Open Data"),
      " (the World Development Indicators), published by the World Bank under the ",
      link("https://creativecommons.org/licenses/by/4.0/", "Creative Commons Attribution 4.0"),
      " license. The World Bank updates these figures about once a year; values missing from",
      " its data are missing from the charts too. The definitions in the Index tab are the",
      " World Bank's own."
    ),
    h3("Acknowledgments"),
    p(
      "Thanks to the ", strong("World Bank"), " for making its data open and free to reuse."
    ),
    p(
      "The app is built with ",
      link("https://shiny.posit.co/", "Shiny"), " and ",
      link("https://thinkr-open.github.io/golem/", "golem"), "; the charts are drawn with ",
      link("https://plotly.com/r/", "plotly"), " (whose world map uses the country borders of ",
      link("https://www.naturalearthdata.com/", "Natural Earth"), "), the tables with ",
      link("https://rstudio.github.io/DT/", "DT"), " (DataTables), and the data is prepared with ",
      link("https://dplyr.tidyverse.org/", "dplyr"), ". Thanks to their authors and to the R community."
    ),
    p(
      "The borders and names of the countries are those of the World Bank and Natural Earth,",
      " and do not imply any judgment on the legal status of any territory."
    ),
    h3("License and source"),
    p(
      "golemworldbank is free software under the ",
      link("https://www.gnu.org/licenses/gpl-3.0.html", "GNU General Public License v3"), ".",
      " Source code: ", link("https://github.com/sedzinfo/golemworldbank", "github.com/sedzinfo/golemworldbank"),
      "; documentation: ", link("https://sedzinfo.github.io/golemworldbank/", "sedzinfo.github.io/golemworldbank"),
      "; issues and suggestions: ", link("https://github.com/sedzinfo/golemworldbank/issues", "the issues page"), "."
    ),
    p("Author and maintainer: Dimitrios Zacharatos.")
  )
}
