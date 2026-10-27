##########################################################################################
#
##########################################################################################
#' @title World Bank indicator values
#' @description The values of the World Development Indicators in long format, one row
#' per country, indicator and year: 217 countries, 1,497 indicators, the years
#' 1960 to 2025. Regions and income groups (such as "World") are not included,
#' and neither are missing values. This is the data of every tab except the
#' Pyramid.
#' @format A data frame with 7,505,749 rows and 5 columns:
#' \describe{
#'   \item{Country Code}{Three-letter World Bank code of the country, e.g. "GRC".}
#'   \item{Country Name}{Country name, e.g. "Greece".}
#'   \item{Indicator Name}{Indicator name, e.g. "Population, total".}
#'   \item{Year}{Year of observation (factor).}
#'   \item{value}{Value of the indicator for that country and year.}
#' }
#' @source World Bank Open Data (\url{https://data.worldbank.org}).
#' @examples
#' \donttest{
#' head(mfi)
#' }
"mfi"
##########################################################################################
#
##########################################################################################
#' @title Population by age group and sex
#' @description The share of each five-year age group in the male and in the female
#' population, per country and year: the 32 indicators of [mfi] such as
#' "Population ages 40-44, male (% of male population)", with their age group
#' and sex in columns of their own. This is the data of the Pyramid tab.
#' @format A data frame with 458,304 rows and 7 columns:
#' \describe{
#'   \item{Country Name}{Country name.}
#'   \item{Indicator Name}{Indicator name, as in [mfi].}
#'   \item{Year}{Year of observation (factor).}
#'   \item{value}{Percent of the male or of the female population.}
#'   \item{age}{Age group (factor, "00-04" to "80+").}
#'   \item{unit}{Unit of `value`: always "Percent".}
#'   \item{sex}{"Male" or "Female".}
#' }
#' @source World Bank Open Data (\url{https://data.worldbank.org}).
#' @examples
#' \donttest{
#' head(mfi_population)
#' }
"mfi_population"
##########################################################################################
#
##########################################################################################
#' @title Country and region reference table
#' @description The World Bank metadata of each country and aggregate: its names, region,
#' income group and statistical practices. The app uses `Short Name`, matched
#' to `Country Name` of [mfi], and `Region` (empty for the aggregates), to
#' color the bubbles of the Scatterplot tab by region.
#' @format A data frame with 265 rows and 31 columns, including
#' `Country Code`, `Short Name`, `Table Name`, `Long Name`, `Region`, and
#' `Income Group`.
#' @source World Bank Open Data (\url{https://data.worldbank.org}).
#' @examples
#' \donttest{
#' head(country_code)
#' }
"country_code"
##########################################################################################
#
##########################################################################################
#' @title Indicator topics and definitions
#' @description World Bank topic and definition of every indicator in [mfi], shown in the
#' Index tab.
#' @format A data frame with 1,497 rows and 3 columns:
#' \describe{
#'   \item{Indicator Name}{Indicator name, as in [mfi].}
#'   \item{Topic}{World Bank topic, e.g. "Health: Population: Structure".}
#'   \item{Definition}{Short definition of the indicator.}
#' }
#' @source World Bank Open Data (\url{https://data.worldbank.org}), WDISeries.csv.
#' @examples
#' \donttest{
#' head(indicator_info)
#' }
"indicator_info"
