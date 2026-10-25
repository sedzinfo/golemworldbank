#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @importFrom dplyr %>%
#' @usage lhs \%>\% rhs
#' @export
NULL

#' Shared plotly font style
#'
#' Applied to the `font` argument of every `plotly::layout()` call across the
#' app's plot-building functions, so charts share one look.
#'
#' @keywords internal
#' @export
#' @examples
#' plotly::layout(plotly::plot_ly(), font = font_style)
font_style <- list(size = 20, color = "gray25", weight = "bold")

#' Format a large number with a magnitude suffix
#'
#' Abbreviates a numeric value using Tn/Bn/M/K suffixes (trillions,
#' billions, millions, thousands), rounding to the nearest whole unit.
#' Values under 1,000 are returned as-is (coerced to character).
#'
#' @param n Numeric vector of values to format.
#'
#' @return A character vector of formatted values.
#'
#' @noRd
#'
#' @examples
#' format_bignum(c(950, 1500, 2500000, 3200000000, 4100000000000))
#' #> [1] "950" "2 K" "2 M" "3 Bn" "4 Tn"
format_bignum <- function(n) {
  dplyr::case_when(
    n >= 1e12 ~ paste(round(n / 1e12), "Tn"),
    n >= 1e9 ~ paste(round(n / 1e9), "Bn"),
    n >= 1e6 ~ paste(round(n / 1e6), "M"),
    n >= 1e3 ~ paste(round(n / 1e3), "K"),
    TRUE ~ as.character(n)
  )
}
##########################################################################################
# 
##########################################################################################
#' @importFrom stats complete.cases reshape
#' @importFrom utils globalVariables
NULL
# the packaged datasets and the data frame columns that the code refers to by name
globalVariables(c("mfi", "mfi_population", "country_code", "Year", "value"))
