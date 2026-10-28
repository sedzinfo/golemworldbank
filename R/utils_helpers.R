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
#' @importFrom stats complete.cases reshape
#' @importFrom utils globalVariables
NULL
# the packaged datasets and the data frame columns that the code refers to by name
globalVariables(c("mfi", "mfi_population", "country_code", "indicator_info", "Year", "value"))
##########################################################################################
# 
##########################################################################################
#' @title Format numbers compactly to 3 significant digits
#' @description Abbreviates numbers to 3 significant digits with the suffixes k, M, B and T
#' (thousands, millions, billions, trillions); negative and small values keep
#' their sign and digits (6.02M, 1.42B, 0.0752, -5.72B).
#' Used for the labels and the hover text of the bars in [plot_bar()].
#' @param n Numeric vector of values to format.
#' @return A character vector of formatted values.
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
#' @description Builds the `updatemenus` entry shown next to plotly's own Play button,
#' used by every animated chart of the app. Pause halts the animation on the
#' current frame; Stop halts it and jumps back to the first frame.
#' @param first_frame Character. Name of the first animation frame (for these
#'   charts, the first year).
#' @return A list to pass as `plotly::layout(updatemenus = ...)`.
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
##########################################################################################
#
##########################################################################################
#' @title Keep the legend clicks of an animated plotly chart
#' @description plotly writes `visible` into every trace of every animation frame, so a
#' trace hidden with a click on the legend comes back on the next frame. This
#' removes `visible` from the frames, so the click lasts while the animation
#' plays. plotly also hides a trace, with `visible = FALSE`, in a frame where it
#' has no data, as a copy of its previous frame; that copy is emptied instead,
#' so nothing is drawn there.
#' @param p A `plotly` object with frames.
#' @return The built `plotly` object.
#' @export
#' @examples
#' keep_legend_clicks(plot_pyramid(mfi_population, country = "Greece", font_style = font_style))
keep_legend_clicks <- function(p) {
  p <- plotly::plotly_build(p)
  without_visible <- function(trace) {
    if (isFALSE(trace$visible)) trace$x <- trace$y <- rep(NA, length(trace$x))
    trace$visible <- NULL
    trace
  }
  p$x$data <- lapply(p$x$data, without_visible)
  for (k in seq_along(p$x$frames)) {
    p$x$frames[[k]]$data <- lapply(p$x$frames[[k]]$data, without_visible)
  }
  p
}
