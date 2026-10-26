##########################################################################################
# 
##########################################################################################
#' Build a country comparison line chart
#'
#' Plots one indicator's value over time as one line per selected country.
#' Rows with missing values for the given filters are dropped before
#' plotting.
#'
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns).
#' @param countries Character vector of country names to plot.
#' @param indicator Character. Indicator name to plot.
#' @param font_style A `plotly` font list (e.g. `list(size = 20, color =
#'   "gray25")`) applied to the chart's layout.
#'
#' @return A `plotly` htmlwidget.
#' @export
#' @examples
#' plot_country_comp(
#'   mfi,
#'   countries = c("Greece", "Bulgaria"),
#'   indicator = "Population, total",
#'   font_style = font_style
#' )
plot_country_comp <- function(mfi, countries, indicator, font_style) {
  temp <- mfi[mfi$`Country Name` %in% countries & mfi$`Indicator Name` %in% indicator, ]
  temp <- temp[complete.cases(temp), ]
  temp$Year <- droplevels(temp$Year)
  plotly::plot_ly(temp,
    x = ~ temp$Year,
    y = ~ temp$value,
    text = ~ paste0(
      "\nCountry=", temp$`Country Name`,
      "\nIndicator=", temp$`Indicator Name`,
      "\nYear=", temp$Year,
      "\nValue=", temp$value
    ),
    color = ~ temp$`Country Name`,
    mode = "lines+markers",
    type = "scatter",
    showlegend = TRUE
  ) %>%
    plotly::layout(
      autosize = TRUE,
      margin = list(l = 50, r = 50, b = 250, t = 100, pad = 0),
      legend = list(orientation = "h", xanchor = "center", x = .5, y = 1),
      title = paste("Indicator:", indicator),
      xaxis = list(title = "Year", tickangle = -90),
      yaxis = list(title = indicator),
      showlegend = TRUE,
      font = font_style
    ) %>%
    plotly::config(responsive = TRUE)
}
##########################################################################################
# 
##########################################################################################
#' Build an indicator comparison line chart
#'
#' Plots several indicators' values over time, for a single country, as one
#' line per indicator. Rows with missing values for the given filters are
#' dropped before plotting.
#'
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns).
#' @param country Character. Country name to plot.
#' @param indicators Character vector of indicator names to plot.
#' @param font_style A `plotly` font list (e.g. `list(size = 20, color =
#'   "gray25")`) applied to the chart's layout.
#'
#' @return A `plotly` htmlwidget.
#' @export
#' @examples
#' plot_indicator_comp(
#'   mfi,
#'   country = "Greece",
#'   indicators = c("Population, female", "Population, male"),
#'   font_style = font_style
#' )
plot_indicator_comp <- function(mfi, country, indicators, font_style) {
  temp <- mfi[mfi$`Country Name` %in% country & mfi$`Indicator Name` %in% indicators, ]
  temp <- temp[complete.cases(temp), ]
  temp$Year <- droplevels(temp$Year)
  plotly::plot_ly(temp,
    x = ~ temp$Year,
    y = ~ temp$value,
    color = ~ temp$`Indicator Name`,
    mode = "lines+markers",
    type = "scatter",
    showlegend = TRUE
  ) %>%
    plotly::layout(
      autosize = TRUE,
      margin = list(l = 50, r = 50, b = 250, t = 100, pad = 0),
      legend = list(orientation = "h", xanchor = "center", x = .5, y = 1),
      title = paste("Country:", country),
      xaxis = list(title = "Year", tickangle = -90),
      yaxis = list(title = ""),
      showlegend = TRUE,
      font = font_style
    ) %>%
    plotly::config(responsive = TRUE)
}
##########################################################################################
# 
##########################################################################################
#' Build an animated population pyramid
#'
#' Plots male (negative, left) and female (positive, right) population
#' counts by age group as horizontal bars, animated over `Year`. Male values
#' are negated internally so the two sexes render back-to-back, while
#' `display_value` keeps the original (positive) counts for hover/axis text.
#'
#' @param mfi_population Data frame of population-by-age/sex values (long
#'   format, with `Country Name`, `sex`, `age`, `Year`, `value` columns).
#' @param country Character. Country name to plot.
#' @param font_style A `plotly` font list (e.g. `list(size = 20, color =
#'   "gray25")`) applied to the chart's layout.
#'
#' @return A `plotly` htmlwidget.
#' @export
#' @examples
#' plot_pyramid(mfi_population, country = "Greece", font_style = font_style)
plot_pyramid <- function(mfi_population, country, font_style) {
  temp <- mfi_population[mfi_population$`Country Name` %in% country, ]
  temp <- temp[complete.cases(temp), ]
  temp[temp$sex %in% "Male", "value"] <- temp[temp$sex %in% "Male", "value"] * -1
  temp$value <- round(temp$value, 2)
  temp$Year <- droplevels(temp$Year)
  temp$display_value <- NA
  temp[temp$sex %in% "Male", "display_value"] <- temp[temp$sex %in% "Male", "value"] * -1
  temp[temp$sex %in% "Female", "display_value"] <- temp[temp$sex %in% "Female", "value"]
  plotly::plot_ly(temp,
    x = ~ temp$value,
    y = ~ temp$age,
    color = ~ temp$sex,
    ids = ~ temp$age,
    type = "bar",
    frame = ~Year,
    orientation = "h",
    hoverinfo = "text",
    textposition = "outside",
    text = ~ temp$display_value
  ) %>%
    plotly::layout(
      autosize = TRUE,
      bargap = .1,
      barmode = "overlay",
      title = paste("Country:", country),
      margin = list(l = 50, r = 50, b = 250, t = 100, pad = 0),
      yaxis = list(title = "Age Group"),
      xaxis = list(
        title = list(text = "Population", standoff = 3),
        tickmode = "array",
        tickvals = -100:100,
        ticktext = paste0(c(100:0, 1:100), "%")
      ),
      font = font_style
    ) %>%
    plotly::animation_opts(frame = 500, easing = "linear", redraw = TRUE, mode = "immediate") %>%
    plotly::config(responsive = TRUE)
}
##########################################################################################
# 
##########################################################################################
#' Build an animated ranked bar chart
#'
#' Plots one indicator's top `top_n` countries per year as a horizontal bar
#' chart animated over `Year` (a "bar chart race"): in every frame the bars are
#' re-ranked, so a country that overtakes another moves up, and the value axis
#' is fitted to that year's largest value. Each bar carries the country name
#' and its value. Only positive, complete-case rows are kept. Returns `NULL`
#' when fewer than two rows remain after filtering.
#'
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns).
#' @param indicator Character. Indicator name to plot.
#' @param font_style A `plotly` font list (e.g. `list(size = 20, color =
#'   "gray25")`) applied to the chart's layout.
#' @param top_n Integer. Number of countries shown in each year.
#'
#' @return A `plotly` htmlwidget, or `NULL` if there is not enough data to
#'   plot.
#' @export
#' @examples
#' plot_bar(mfi, indicator = "GDP (current US$)", font_style = font_style)
plot_bar <- function(mfi, indicator, font_style, top_n = 20) {
  temp <- mfi[mfi$`Indicator Name` %in% indicator, ]
  temp <- temp[complete.cases(temp), ]
  temp <- temp[temp$value > 0, ]
  if (nrow(temp) <= 1) {
    return(NULL)
  }
  temp$Year <- droplevels(temp$Year)
  # rank within each year (1 = largest), keep the top_n
  temp <- temp[order(temp$Year, -temp$value), ]
  temp$rank <- stats::ave(temp$value, temp$Year, FUN = seq_along)
  temp <- data.frame(temp[temp$rank <= top_n, ], check.names = FALSE)
  temp$label <- paste0(temp$`Country Name`, "  ", format_value(temp$value))

  p <- plotly::plot_ly(temp,
    x = ~value,
    y = ~rank,
    frame = ~Year,
    ids = ~ `Country Name`,
    type = "bar",
    orientation = "h",
    text = ~label,
    textposition = "outside",
    cliponaxis = FALSE,
    hovertext = ~ paste0(
      "Rank=", rank,
      "\nCountry=", `Country Name`,
      "\nValue=", format_value(value)
    ),
    hoverinfo = "text",
    marker = list(color = "#4A64FF")
  ) %>%
    plotly::layout(
      autosize = TRUE,
      title = paste0(unique(temp$`Indicator Name`)),
      margin = list(l = 50, r = 50, b = 100, t = 100, pad = 0),
      # rank 1 at the top; ranks instead of names on the axis (the names are on the bars)
      yaxis = list(title = "", autorange = "reversed", dtick = 1, zeroline = FALSE),
      xaxis = list(title = "", showticklabels = FALSE, zeroline = FALSE, showgrid = FALSE),
      font = font_style,
      showlegend = FALSE
    ) %>%
    plotly::animation_opts(frame = 800, transition = 600, easing = "linear", redraw = FALSE, mode = "immediate") %>%
    plotly::config(responsive = TRUE)

  # fit the value axis to each year's largest value (room on the right for the labels)
  p <- plotly::plotly_build(p)
  year_max <- tapply(temp$value, as.character(temp$Year), max)
  for (k in seq_along(p$x$frames)) {
    fmax <- year_max[[p$x$frames[[k]]$name]]
    p$x$frames[[k]]$layout <- list(xaxis = list(range = c(0, fmax * 1.6)))
  }
  p$x$layout$xaxis$range <- c(0, year_max[[p$x$frames[[1]]$name]] * 1.6)
  p
}
##########################################################################################
# 
##########################################################################################
#' Build an animated choropleth map
#'
#' Plots one indicator's value per country as a world choropleth, animated
#' over `Year`. Rows with missing values are dropped before plotting.
#'
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Country Code`, `Indicator Name`, `Year`, `value`
#'   columns).
#' @param indicator Character. Indicator name to plot.
#' @param font_style A `plotly` font list (e.g. `list(size = 20, color =
#'   "gray25")`) applied to the chart's layout.
#'
#' @return A `plotly` htmlwidget.
#' @export
#' @examples
#' plot_map(mfi, indicator = "Population, total", font_style = font_style)
plot_map <- function(mfi, indicator, font_style) {
  g <- list(showframe = FALSE, showcoastlines = TRUE, projection = list(type = "Mercator"))
  temp <- mfi[mfi$`Indicator Name` %in% indicator, ]
  temp <- temp[complete.cases(temp), ]
  temp$Year <- droplevels(temp$Year)
  plotly::plot_ly(temp,
    z = ~value,
    frame = ~Year,
    text = ~ temp$`Country Name`,
    locations = ~ temp$`Country Code`,
    color = ~ temp$value,
    type = "choropleth",
    colorbar = list(tickprefix = "", title = ""),
    colors = "Blues"
  ) %>%
    plotly::layout(
      autosize = TRUE,
      showlegend = TRUE,
      margin = list(l = 50, r = 50, b = 250, t = 100, pad = 0),
      legend = list(orientation = "h", xanchor = "center", x = .5, y = 1),
      title = paste("Indicator:", indicator),
      xaxis = list(title = ""),
      yaxis = list(title = ""),
      geo = g,
      font = font_style
    ) %>%
    plotly::animation_opts(frame = 1000, easing = "linear", redraw = TRUE, mode = "immediate") %>%
    plotly::config(responsive = TRUE)
}
##########################################################################################
# 
##########################################################################################
#' Build an animated correlation bubble scatter plot
#'
#' Reshapes `mfi` from long to wide so `indicator1` and `indicator2` become
#' plottable x/y columns, joins in `Region` from `country_code`, and plots a
#' bubble scatter (bubble size = population, color = region), animated over
#' `Year`, with play/pause controls. Rows with missing values or no region
#' are dropped before plotting.
#'
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns). Must also
#'   contain a `"Population, total"` indicator, used for bubble sizing.
#' @param country_code Data frame mapping countries to region, with columns
#'   `Country Code`, `Short Name`, `Region`.
#' @param indicator1 Character. Indicator name plotted on the x-axis.
#' @param indicator2 Character. Indicator name plotted on the y-axis.
#' @param font_style A `plotly` font list (e.g. `list(size = 20, color =
#'   "gray25")`) applied to the chart's layout.
#'
#' @return A `plotly` htmlwidget.
#' @export
#' @examples
#' plot_cor(
#'   mfi,
#'   country_code,
#'   indicator1 = "Mortality rate, adult, male (per 1,000 male adults)",
#'   indicator2 = "Mortality rate, infant (per 1,000 live births)",
#'   font_style = font_style
#' )
plot_cor <- function(mfi, country_code, indicator1, indicator2, font_style) {
  mfi_temp <- mfi[mfi$`Indicator Name` %in% c(indicator1, indicator2, "Population, total"), ]
  mfi_cor <- reshape(mfi_temp[, c("Country Name", "Indicator Name", "Year", "value")],
    timevar = "Indicator Name",
    idvar = c("Country Name", "Year"),
    direction = "wide"
  )
  names(mfi_cor) <- gsub("value.", "", names(mfi_cor), fixed = TRUE)
  row.names(mfi_cor) <- NULL

  mfi_cor <- merge(country_code[, c("Country Code", "Short Name", "Region")], mfi_cor, by.x = c("Short Name"), by.y = c("Country Name"), all.y = TRUE)

  factorlist <- c("Year", "Short Name", "Region", "Population, total")
  temp <- mfi_cor[, c(indicator1, indicator2, factorlist)]
  temp <- temp[complete.cases(temp), ]
  temp$Region[temp$Region == ""] <- NA
  temp <- temp[!is.na(temp$Region), ]
  temp$Year <- droplevels(temp$Year)
  plotly::plot_ly(temp,
    x = temp[, 1],
    y = temp[, 2],
    color = ~ temp$Region,
    size = ~ temp$`Population, total`,
    frame = ~Year,
    ids = ~ temp$`Short Name`,
    text = ~ paste(
      "\nRegion=", temp$Region,
      "\nCountry=", temp$`Short Name`
    ),
    type = "scatter",
    mode = "markers",
    fill = ~"",
    marker = list(sizemode = "diameter")
  ) %>%
    plotly::layout(
      autosize = TRUE,
      showlegend = TRUE,
      margin = list(l = 50, r = 50, b = 250, t = 100, pad = 0),
      title = "",
      xaxis = list(title = list(text = unique(indicator1), standoff = 3)),
      yaxis = list(title = unique(indicator2)),
      font = font_style
    ) %>%
    plotly::animation_opts(frame = 500, easing = "linear", redraw = TRUE, mode = "afterall") %>%
    plotly::layout(
      updatemenus = list(
        list(
          type = "buttons",
          direction = "right",
          x = 0,
          y = 0,
          showactive = FALSE,
          buttons = list(
            list(
              label = "Pause",
              method = "animate",
              args = list(NULL, list(mode = "none"))
            ),
            list(
              label = "Stop",
              method = "animate",
              args = list(NULL, list(mode = "immediate"))
            )
          )
        )
      )
    ) %>%
    plotly::config(responsive = TRUE)
}
##########################################################################################
# 
##########################################################################################
#' Build the indicator index DataTable
#'
#' Builds a single-column, non-paginated `DT::datatable` listing every
#' distinct indicator name present in `mfi`.
#'
#' @param mfi Data frame of World Bank indicator values, with an
#'   `Indicator Name` column.
#'
#' @return A `DT::datatable` htmlwidget.
#' @export
#' @examples
#' render_index_table(mfi)
render_index_table <- function(mfi) {
  data <- data.frame(Indicator = unique(mfi$`Indicator Name`))
  result <- DT::datatable(data, options = list(paging = FALSE))
  DT::formatStyle(result, names(result), 0, target = "row", lineHeight = "80%")
}
