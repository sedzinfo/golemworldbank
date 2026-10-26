##########################################################################################
#
##########################################################################################
#' Indicators that rose or fell between two years for one country
#'
#' Compares every indicator a country has a value for in both years and splits
#' them into two tables: the ones that increased from `year1` to `year2` and the
#' ones that decreased, each sorted by percent change (largest change first).
#' Percent change is `(value2 - value1) / |value1| * 100`; it is undefined when
#' the `year1` value is 0, so those indicators are left out of both tables (their
#' names are kept in the `zero_base` element). Indicators that did not change
#' are in neither table.
#'
#' Rates of change ("annual %", "% change", "growth", e.g. "GDP growth (annual
#' %)", "Inflation, consumer prices (annual %)", "... (% change from 1990)") are
#' left out by default: a percent
#' change of a growth rate is not meaningful (a rate going from -0.01 to 1.7
#' reads as +17,000%). `include_rates = TRUE` keeps them.
#'
#' For indicators that are themselves percentages (e.g. "Urban population (% of
#' total population)") the percent change is relative to the old percentage, not
#' a difference in percentage points; the `Change` column gives the plain
#' difference.
#'
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns).
#' @param country Character. Country name, as in `Country Name`.
#' @param year1,year2 Numeric or character. The two years to compare.
#' @param include_sign_change Logical. Keep indicators whose value changed sign
#'   between the two years (e.g. net FDI inflows from -8 million to +6.7
#'   billion): their percent change is not meaningful (+82,000%). `FALSE`
#'   (default) leaves them out and lists them in `sign_change`.
#' @param include_rates Logical. Keep the rate-of-change indicators (names
#'   containing "annual %", "% change" or "growth"); `FALSE` (default) leaves
#'   them out.
#'
#' @return A list with `increased` and `decreased` (data frames with columns
#'   `Indicator`, the two years' values, `Change` and `Change %`),
#'   `zero_base` (indicators left out because their `year1` value is 0) and
#'   `sign_change` (indicators whose value changed sign; left out unless
#'   `include_sign_change = TRUE`).
#' @export
#' @examples
#' res <- indicator_change(mfi, country = "Greece", year1 = 2024, year2 = 2025)
#' head(res$increased)
#' head(res$decreased)
indicator_change <- function(mfi, country, year1, year2, include_rates = FALSE,
                             include_sign_change = FALSE) {
  temp <- mfi[mfi$`Country Name` %in% country &
                as.character(mfi$Year) %in% as.character(c(year1, year2)), ]
  if (nrow(temp) == 0) stop("No data for ", country, " in ", year1, " or ", year2, call. = FALSE)
  v1 <- temp[as.character(temp$Year) == as.character(year1), c("Indicator Name", "value")]
  v2 <- temp[as.character(temp$Year) == as.character(year2), c("Indicator Name", "value")]
  both <- merge(v1, v2, by = "Indicator Name", suffixes = c("_1", "_2"))
  both <- both[complete.cases(both), ]
  if (!include_rates) {
    is_rate <- grepl("annual %", both$`Indicator Name`, fixed = TRUE) |
      grepl("% change", both$`Indicator Name`, fixed = TRUE) |
      grepl("growth", both$`Indicator Name`, ignore.case = TRUE)
    both <- both[!is_rate, ]
  }

  zero_base <- both$`Indicator Name`[both$value_1 == 0]
  both <- both[both$value_1 != 0, ]
  flipped <- sign(both$value_1) != sign(both$value_2) & both$value_2 != 0
  sign_change <- both$`Indicator Name`[flipped]
  if (!include_sign_change) both <- both[!flipped, ]
  both$change <- both$value_2 - both$value_1
  both$pct <- both$change / abs(both$value_1) * 100

  as_table <- function(x) {
    out <- data.frame(x$`Indicator Name`, x$value_1, x$value_2, x$change, round(x$pct, 2),
                      check.names = FALSE, stringsAsFactors = FALSE)
    names(out) <- c("Indicator", as.character(year1), as.character(year2), "Change", "Change %")
    row.names(out) <- NULL
    out
  }
  increased <- both[both$pct > 0, ]
  decreased <- both[both$pct < 0, ]
  list(
    increased = as_table(increased[order(-increased$pct), ]),
    decreased = as_table(decreased[order(decreased$pct), ]),
    zero_base = zero_base,
    sign_change = sign_change
  )
}
##########################################################################################
# 
##########################################################################################
#' Render one table of [indicator_change()] as a DataTable
#'
#' Values and the absolute change are shown compactly to 3 significant digits
#' (6.02M, 1.42B, 0.0752); sorting still uses the full numbers. The percent
#' change has one decimal, coloured green (increase) or red (decrease).
#'
#' @param tab One of the data frames returned by [indicator_change()]
#'   (`increased` or `decreased`).
#'
#' @return A `DT::datatable` htmlwidget.
#' @export
#' @examples
#' res <- indicator_change(mfi, country = "Greece", year1 = 2000, year2 = 2020)
#' render_change_table(res$increased)
render_change_table <- function(tab) {
  # display-only formatting: the cells keep their numbers, so sorting is numeric
  compact <- DT::JS(
    "function(data, type) {",
    "  if (type !== 'display' || data === null) return data;",
    "  return new Intl.NumberFormat('en', {notation: 'compact', maximumSignificantDigits: 3}).format(data);",
    "}"
  )
  result <- DT::datatable(tab,
    rownames = FALSE,
    options = list(
      paging = FALSE,   # one long page, like the Index table (no inner scroll box)
      columnDefs = list(list(targets = 1:3, render = compact, className = "dt-right"))
    )
  )
  result <- DT::formatRound(result, "Change %", digits = 1)
  result <- DT::formatStyle(result, "Change %",
    color = DT::styleInterval(0, c("#B3261E", "#1E7B34")),
    fontWeight = "bold"
  )
  # same compact rows as the Index table
  DT::formatStyle(result, names(tab), 0, target = "row", lineHeight = "80%")
}
