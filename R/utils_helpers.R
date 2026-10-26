##########################################################################################
# 
##########################################################################################
#' @title Pipe operator
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @importFrom dplyr %>%
#' @usage lhs \%>\% rhs
#' @export
NULL
##########################################################################################
# 
##########################################################################################
#' @title Shared plotly font style
#' @description Applied to the `font` argument of every `plotly::layout()` call across the
#' app's plot-building functions, so charts share one look.
#' @keywords internal
#' @export
#' @examples
#' plotly::layout(plotly::plot_ly(), font = font_style)
font_style <- list(size = 20, color = "gray25", weight = "bold")
##########################################################################################
# 
##########################################################################################
#' @title Format a large number with a magnitude suffix
#' @description Abbreviates a numeric value using Tn/Bn/M/K suffixes (trillions,
#' billions, millions, thousands), rounding to the nearest whole unit.
#' Values under 1,000 are returned as-is (coerced to character).
#' @param n Numeric vector of values to format.
#' @return A character vector of formatted values.
#' @export
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
globalVariables(c("mfi", "mfi_population", "country_code", "indicator_info", "Year", "value"))
##########################################################################################
# 
##########################################################################################
#' @title Format numbers compactly to 3 significant digits
#' @description Like [format_bignum()] but keeps 3 significant digits, handles negative and
#' small values, and uses the k/M/B/T suffixes (6.02M, 1.42B, 0.0752, -5.72B).
#' @param n Numeric vector of values to format.
#' @return A character vector of formatted values.
#' @noRd
#' @export
#' @examples
#' format_value(c(0.0752, 950, 1520, 6020000, -5720000000, 29200000000000))
#' #> [1] "0.0752" "950" "1.52k" "6.02M" "-5.72B" "29.2T"
format_value <- function(n) {
  a <- abs(n)
  div <- ifelse(a >= 1e12, 1e12, ifelse(a >= 1e9, 1e9, ifelse(a >= 1e6, 1e6, ifelse(a >= 1e3, 1e3, 1))))
  suf <- ifelse(a >= 1e12, "T", ifelse(a >= 1e9, "B", ifelse(a >= 1e6, "M", ifelse(a >= 1e3, "k", ""))))
  paste0(trimws(formatC(signif(n / div, 3), format = "fg", digits = 3)), suf)
}
##########################################################################################
# 
##########################################################################################
#' @title Pause and Stop buttons for an animated plotly chart
#' @description Builds the `updatemenus` entry shown next to plotly's own Play button.
#' Pause halts the animation on the current frame; Stop halts it and jumps
#' back to the first frame.
#' @param first_frame Character. Name of the first animation frame (for these
#'   charts, the first year).
#' @return A list to pass as `plotly::layout(updatemenus = ...)`.
#' @noRd
#' @export
#' @examples
#' plotly::layout(p, updatemenus = animation_buttons("1960"))
animation_buttons <- function(first_frame) {
  # duration 0 makes plotly drop the queued frames instead of finishing them
  halt <- list(mode = "immediate", frame = list(duration = 0, redraw = TRUE), transition = list(duration = 0))
  list(
    list(
      type = "buttons",
      direction = "right",
      x = 0,
      y = 0,
      showactive = FALSE,
      buttons = list(
        list(label = "Pause", method = "animate", args = list(list(NULL), halt)),
        list(label = "Stop", method = "animate", args = list(list(first_frame), halt))
      )
    )
  )
}
