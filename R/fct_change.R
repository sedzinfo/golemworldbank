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
#' For indicators that are themselves percentages (e.g. "Urban population (% of
#' total population)") the percent change is relative to the old percentage, not
#' a difference in percentage points; the `Change` column gives the plain
#' difference.
#'
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns).
#' @param country Character. Country name, as in `Country Name`.
#' @param year1,year2 Numeric or character. The two years to compare.
#'
#' @return A list with `increased` and `decreased` (data frames with columns
#'   `Indicator`, the two years' values, `Change` and `Change %`) and
#'   `zero_base` (indicators left out because their `year1` value is 0).
#' @export
#' @examples
#' res <- indicator_change(mfi, country = "Greece", year1 = 2000, year2 = 2024)
#' head(res$increased)
#' head(res$decreased)
indicator_change <- function(mfi, country, year1, year2) {
  temp <- mfi[mfi$`Country Name` %in% country &
                as.character(mfi$Year) %in% as.character(c(year1, year2)), ]
  if (nrow(temp) == 0) stop("No data for ", country, " in ", year1, " or ", year2, call. = FALSE)
  v1 <- temp[as.character(temp$Year) == as.character(year1), c("Indicator Name", "value")]
  v2 <- temp[as.character(temp$Year) == as.character(year2), c("Indicator Name", "value")]
  both <- merge(v1, v2, by = "Indicator Name", suffixes = c("_1", "_2"))
  both <- both[complete.cases(both), ]

  zero_base <- both$`Indicator Name`[both$value_1 == 0]
  both <- both[both$value_1 != 0, ]
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
    zero_base = zero_base
  )
}
