##########################################################################################
# 
##########################################################################################
#' @title Pipe operator
#' @description Re-exported from dplyr, so that the code of the package and its users
#' can chain calls with it. See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for
#' details.
#' @param lhs A value.
#' @param rhs A function call, which gets `lhs` as its first argument.
#' @return The result of the call `rhs` with `lhs` as its first argument.
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
#' @title Font of the charts
#' @description The font of every chart of the app: 20 px, bold, dark gray. The app passes
#' it as the `font_style` argument of the `plot_*()` functions, which give it
#' to `plotly::layout(font = )`, so that all the charts share one look.
#' @format A list with the elements `size`, `color` and `weight`.
#' @keywords internal
#' @export
#' @examples
#' plotly::layout(plotly::plot_ly(), font = font_style)
font_style <- list(size = 20, color = "gray25", weight = "bold")
##########################################################################################
# 
##########################################################################################
#' @title Format a large number with a magnitude suffix
#' @description Abbreviates numbers with the suffixes Tn, Bn, M and K (trillions,
#' billions, millions, thousands), rounded to a whole number of that unit, so
#' 1,500 becomes "2 K". Numbers under 1,000 are returned unchanged, as text.
#' For 3 significant digits ("1.52k"), as on the bars of the Barplot tab, see
#' the internal `format_value()`.
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
#' Used for the labels and the hover text of the bars in [plot_bar()].
#' @param n Numeric vector of values to format.
#' @return A character vector of formatted values.
#' @noRd
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
#' @description Builds the `updatemenus` entry shown next to plotly's own Play button,
#' used by every animated chart of the app. Pause halts the animation on the
#' current frame; Stop halts it and jumps back to the first frame.
#' @param first_frame Character. Name of the first animation frame (for these
#'   charts, the first year).
#' @return A list to pass as `plotly::layout(updatemenus = ...)`.
#' @noRd
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
