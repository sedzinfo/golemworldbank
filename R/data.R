##########################################################################################
# 
##########################################################################################
#' World Bank indicator values
#'
#' Long-format World Bank development indicator values, one row per
#' country/indicator/year.
#'
#' @format A data frame with 7,478,197 rows and 5 columns:
#' \describe{
#'   \item{Country Code}{ISO country code.}
#'   \item{Country Name}{Country name.}
#'   \item{Indicator Name}{World Bank indicator name.}
#'   \item{Year}{Year of observation (factor).}
#'   \item{value}{Indicator value for that country/year.}
#' }
#' @source World Bank Open Data (\url{https://data.worldbank.org}).
#'
#' @examples
#' \donttest{
#' head(mfi)
#' }
"mfi"
##########################################################################################
# 
##########################################################################################
#' Population by age, sex, and country
#'
#' Long-format population counts by five-year age group and sex, used to
#' drive the population pyramid module.
#'
#' @format A data frame with 458,304 rows and 7 columns:
#' \describe{
#'   \item{Country Name}{Country name.}
#'   \item{Indicator Name}{World Bank indicator name.}
#'   \item{Year}{Year of observation (factor).}
#'   \item{value}{Population count.}
#'   \item{age}{Age group.}
#'   \item{unit}{Unit of measurement.}
#'   \item{sex}{"Male" or "Female".}
#' }
#' @source World Bank Open Data (\url{https://data.worldbank.org}).
#'
#' @examples
#' \donttest{
#' head(mfi_population)
#' }
"mfi_population"
##########################################################################################
# 
##########################################################################################
#' Country and region reference table
#'
#' Reference metadata mapping each country to its region, income group, and
#' other World Bank classification metadata.
#'
#' @format A data frame with 265 rows and 31 columns, including
#' `Country Code`, `Short Name`, `Table Name`, `Long Name`, `Region`, and
#' `Income Group`.
#' @source World Bank Open Data (\url{https://data.worldbank.org}).
#'
#' @examples
#' \donttest{
#' head(country_code)
#' }
"country_code"
