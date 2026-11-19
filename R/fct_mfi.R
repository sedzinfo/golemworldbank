##########################################################################################
#
##########################################################################################
#' @title What the package keeps in memory
#' @description The table of [mfi_table()], once built.
#' @noRd
memory <- new.env(parent = emptyenv())
##########################################################################################
#
##########################################################################################
#' @title World Bank indicator values, with the names as text
#' @description The values of the World Development Indicators in long format, one row
#' per country, indicator and year: [mfi] with the names of its countries and
#' indicators as text. The package stores [mfi] with these names as codes
#' (factors), which keeps its file small enough for GitHub without Git LFS and
#' quick to load; this turns them back into text the first time it is called, and
#' keeps the table in memory for the next calls. This is the data of every tab
#' of the app except the Pyramid.
#' @return A data frame with 5 columns: `Country Code`, `Country Name` and
#'   `Indicator Name` (character), `Year` (factor) and `value`.
#' @export
#' @examples
#' head(mfi_table())
mfi_table <- function() {
  if (is.null(memory$mfi)) {
    table <- mfi
    for (column in c("Country Code", "Country Name", "Indicator Name")) {
      table[[column]] <- as.character(table[[column]])
    }
    memory$mfi <- table
  }
  memory$mfi
}
