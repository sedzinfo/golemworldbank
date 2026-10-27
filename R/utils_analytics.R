##########################################################################################
# 
##########################################################################################
#' @title Address of the cookie banner shared by the sites of sedzinfo.github.io
#' @noRd
consent_script <- "https://sedzinfo.github.io/consent.js"
##########################################################################################
# 
##########################################################################################
#' @title Google Analytics for the public deployment
#' @description Loads the cookie banner shared with the sites of sedzinfo.github.io, which
#' loads Google Analytics only after the visitor accepts. The script that
#' reports the tabs as pages (`inst/app/www/analytics.js`) and the style of the
#' banner (`analytics.css`) are always in the page, but send nothing without
#' the banner.
#' @return A `script` tag for the head of the page.
#' @keywords internal
#' @examples
#' golemworldbank:::analytics_resources()
analytics_resources <- function() {
  tags$script(src = consent_script, defer = NA)
}
##########################################################################################
# 
##########################################################################################
#' @title Footer with the links of the cookie banner
#' @description "Cookie settings" opens the banner again, so that visitors can change their
#' choice at any time, as the privacy note promises; "Privacy" opens that
#' note.
#' @return A `div` for the bottom of the page.
#' @keywords internal
#' @examples
#' golemworldbank:::analytics_footer()
analytics_footer <- function() {
  div(
    class = "analytics-footer",
    tags$a(href = "#cookie-settings", "Cookie settings"),
    HTML(" &middot; "),
    tags$a(href = "https://sedzinfo.github.io/privacy.html", "Privacy")
  )
}
