##########################################################################################
# 
##########################################################################################
#' @title Build a country comparison line chart
#' @description Plots one indicator over the years, one line per country, for the Country
#' Comparison tab. The hover text gives the country, indicator, year and value.
#' Rows with a missing value are left out.
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns).
#' @param countries Character vector of country names to plot.
#' @param indicator Character. Indicator name to plot.
#' @param font_style A `plotly` font list for the layout of the chart; the app
#'   passes [font_style].
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
    showlegend = TRUE) %>%
    plotly::layout(
      autosize = TRUE,
      margin = list(l = 50, r = 50, b = 0, t = 100, pad = 0),
      legend = list(orientation = "h", xanchor = "center", x = .5, y = 1),
      title = paste("Indicator:", indicator),
      xaxis = list(title = "", tickangle = -90),
      yaxis = list(title = indicator),
      showlegend = TRUE,
      font = font_style
    ) %>%
    plotly::config(responsive = TRUE)
}
##########################################################################################
# 
##########################################################################################
#' @title Build an indicator comparison line chart
#' @description Plots several indicators over the years for one country, one line per
#' indicator, for the Indicator Comparison tab. The indicators share one y
#' axis, so they compare well only when they have the same unit and a similar
#' scale (e.g. the female and the male population). Rows with a missing value
#' are left out.
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns).
#' @param country Character. Country name to plot.
#' @param indicators Character vector of indicator names to plot.
#' @param font_style A `plotly` font list for the layout of the chart; the app
#'   passes [font_style].
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
    showlegend = TRUE) %>%
    plotly::layout(
      autosize = TRUE,
      margin = list(l = 50, r = 50, b = 0, t = 100, pad = 0),
      legend = list(orientation = "h", xanchor = "center", x = .5, y = 1),
      title = paste("Country:", country),
      xaxis = list(title = "", tickangle = -90),
      yaxis = list(title = ""),
      showlegend = TRUE,
      font = font_style
    ) %>%
    plotly::config(responsive = TRUE)
}
##########################################################################################
# 
##########################################################################################
#' @title Build an animated population pyramid
#' @description Plots, for one country, the share of each five-year age group in the male
#' population (bars to the left) and in the female population (to the right),
#' animated over `Year`, for the Pyramid tab. The male values are negated so
#' that the two sexes stand back to back; the labels on the bars show them
#' positive, and so do the axis ticks (-5 reads "5%").
#' @param mfi_population Data frame of population shares by age group and sex
#'   (long format, with `Country Name`, `sex`, `age`, `Year`, `value` columns),
#'   see [mfi_population].
#' @param country Character. Country name to plot.
#' @param font_style A `plotly` font list for the layout of the chart; the app
#'   passes [font_style].
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
      margin = list(l = 50, r = 50, b = 100, t = 100, pad = 0),
      yaxis = list(title = "Age Group"),
      xaxis = list(
        title = list(text = "Population", standoff = 3),
        tickmode = "array",
        tickvals = -100:100,
        ticktext = paste0(c(100:0, 1:100), "%")
      ),
      font = font_style
    ) %>%
    plotly::animation_opts(frame = 200, transition = 200, easing = "linear", redraw = TRUE, mode = "afterall") %>%
    plotly::layout(updatemenus = animation_buttons(levels(temp$Year)[1])) %>%
    plotly::config(responsive = TRUE)
}
##########################################################################################
# 
##########################################################################################
#' @title Build an animated ranked bar chart
#' @description Plots the `top_n` countries with the largest value of one indicator as
#' horizontal bars, animated over `Year` (a "bar chart race"), for the Barplot
#' tab: in every frame the bars are ranked again, so a country that overtakes
#' another moves up. A country's missing years between two observed ones are
#' filled by linear interpolation, so that it does not drop out of the race
#' for a year and come back; nothing is filled before its first or after its
#' last observed year. Each bar carries the country name and its value, to 3
#' significant digits (1.52k, 6.02M); the bar of `country` is red, so that it
#' can be followed through the race, and the year of the frame is printed
#' large and gray in the bottom right corner. Only rows with a positive value
#' are used.
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns).
#' @param indicator Character. Indicator name to plot.
#' @param font_style A `plotly` font list for the layout of the chart; the app
#'   passes [font_style].
#' @param top_n Integer. Number of countries shown in each year.
#' @param country Character. Country whose bar is drawn red (`NULL` for none).
#' @return A `plotly` htmlwidget, or `NULL` when the indicator has fewer than two
#'   positive values.
#' @export
#' @examples
#' plot_bar(mfi, indicator = "GDP (current US$)", font_style = font_style, country = "Greece")
plot_bar <- function(mfi, indicator, font_style, top_n = 20, country = NULL) {
  temp <- mfi[mfi$`Indicator Name` %in% indicator, ]
  temp <- temp[complete.cases(temp), ]
  temp <- temp[temp$value > 0, ]
  if (nrow(temp) <= 1) {
    return(NULL)
  }
  temp$Year <- droplevels(temp$Year)
  years <- as.numeric(levels(temp$Year))
  # fill each country's gaps between its first and last observed year (no extrapolation)
  temp <- do.call(rbind, lapply(split(temp, temp$`Country Name`), function(d) {
    y <- as.numeric(as.character(d$Year))
    span <- years[years >= min(y) & years <= max(y)]
    v <- if (length(y) < 2) d$value else stats::approx(y, d$value, xout = span)$y
    data.frame(`Country Name` = d$`Country Name`[1], `Indicator Name` = d$`Indicator Name`[1],
               Year = factor(span, levels = levels(temp$Year)), value = v, check.names = FALSE)
  }))
  # rank within each year (1 = largest), keep the top_n
  temp <- temp[order(temp$Year, -temp$value), ]
  temp$rank <- stats::ave(temp$value, temp$Year, FUN = seq_along)
  temp <- data.frame(temp[temp$rank <= top_n, ], check.names = FALSE)
  temp$label <- paste0(temp$`Country Name`, "  ", format_value(temp$value))
  # plotly's default blue for every bar, red for the followed country
  temp$color <- ifelse(temp$`Country Name` %in% country, "#d62728", "#1f77b4")

  p <- plotly::plot_ly(temp,
    x = ~value,
    y = ~rank,
    frame = ~Year,
    ids = ~ `Country Name`,
    type = "bar",
    orientation = "h",
    marker = list(color = ~color),
    text = ~label,
    textposition = "outside",
    cliponaxis = FALSE,
    hovertext = ~ paste0("Rank=", rank,"\nCountry=", `Country Name`,"\nValue=", format_value(value)),
    hoverinfo = "text"
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
    plotly::animation_opts(frame = 1000, transition = 400, easing = "linear", redraw = TRUE, mode = "afterall") %>%
    plotly::layout(updatemenus = animation_buttons(levels(temp$Year)[1])) %>%
    plotly::config(responsive = TRUE)

  p <- plotly::plotly_build(p)
  # the frame's year, big and gray in the bottom right corner (the shortest bars)
  year_label <- function(year) {
    list(list(text = year, xref = "paper", yref = "paper", x = 1, y = 0, xanchor = "right", yanchor = "bottom",
              showarrow = FALSE, font = list(size = 480, color = "rgba(128,128,128,0.35)")))
  }
  p$x$layout$annotations <- year_label(p$x$frames[[1]]$name)
  for (k in seq_along(p$x$frames)) {
    p$x$frames[[k]]$layout <- list(annotations = year_label(p$x$frames[[k]]$name))
  }
  year_max <- tapply(temp$value, as.character(temp$Year), max)
  year_max[] <- cummax(year_max[order(as.numeric(names(year_max)))])[rank(as.numeric(names(year_max)))]
  # for (k in seq_along(p$x$frames)) {
  #   fmax <- year_max[[p$x$frames[[k]]$name]]
  #   p$x$frames[[k]]$layout <- list(xaxis = list(range = c(0, fmax * 1.6)))
  # }
  # p$x$layout$xaxis$range <- c(0, year_max[[p$x$frames[[1]]$name]] * 1.6)
  # plotly draws a frame's layout (the year) only on a redraw, and the race
  # plays with redraw = FALSE: write the year into the drawn annotation as each
  # frame starts. The frames still carry it for Pause/Stop, which redraw.
  htmlwidgets::onRender(p, "function(el) {
    el.on('plotly_animatingframe', function(e) {
      var year = el.querySelector('.annotation-text');
      if (year) year.textContent = e.name;
    });
  }")
}
##########################################################################################
# 
##########################################################################################
#' @title Build an animated choropleth map
#' @description Colors every country of a world map by the value of one indicator, from
#' white (lowest) to dark blue (highest), animated over `Year`, for the Map
#' tab. Countries are placed by their `Country Code`. Rows with a missing
#' value are left out.
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Country Code`, `Indicator Name`, `Year`, `value`
#'   columns).
#' @param indicator Character. Indicator name to plot.
#' @param font_style A `plotly` font list for the layout of the chart; the app
#'   passes [font_style].
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
      margin = list(l = 50, r = 50, b = 100, t = 100, pad = 0),
      legend = list(orientation = "h", xanchor = "center", x = .5, y = 1),
      title = paste("Indicator:", indicator),
      xaxis = list(title = ""),
      yaxis = list(title = ""),
      geo = g,
      font = font_style
    ) %>%
    plotly::animation_opts(frame = 200, transition = 200, easing = "linear", redraw = TRUE, mode = "afterall") %>%
    plotly::layout(updatemenus = animation_buttons(levels(temp$Year)[1])) %>%
    plotly::config(responsive = TRUE)
}
##########################################################################################
# 
##########################################################################################
#' @title Build an animated correlation bubble scatter plot
#' @description Plots every country as a bubble, at its value of `indicator1` (x) and of
#' `indicator2` (y), sized by its population and colored by its region,
#' animated over `Year`, for the Scatterplot tab. The region comes from
#' `country_code`, by matching its `Short Name` to the `Country Name` of `mfi`;
#' a country whose names differ there has no region and is left out, as is a
#' country-year without both values and the population.
#' @param mfi Data frame of World Bank indicator values (long format, with
#'   `Country Name`, `Indicator Name`, `Year`, `value` columns). Must also
#'   contain a `"Population, total"` indicator, used for bubble sizing.
#' @param country_code Data frame mapping countries to region, with columns
#'   `Country Code`, `Short Name`, `Region`.
#' @param indicator1 Character. Indicator name plotted on the x-axis.
#' @param indicator2 Character. Indicator name plotted on the y-axis.
#' @param font_style A `plotly` font list for the layout of the chart; the app
#'   passes [font_style].
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
      margin = list(l = 50, r = 50, b = 100, t = 100, pad = 0),
      title = "",
      xaxis = list(title = list(text = unique(indicator1), standoff = 3)),
      yaxis = list(title = unique(indicator2)),
      font = font_style
    ) %>%
    plotly::animation_opts(frame = 500, easing = "linear", redraw = TRUE, mode = "afterall") %>%
    plotly::layout(updatemenus = animation_buttons(levels(temp$Year)[1])) %>%
    plotly::config(responsive = TRUE)
}
##########################################################################################
# 
##########################################################################################
#' @title Build the indicator index DataTable
#' @description Lists every indicator of `mfi`, in the order it first appears there, with
#' its World Bank topic and definition, for the Index tab. The table is one
#' long page, which can be searched and sorted.
#' @param mfi Data frame of World Bank indicator values, with an
#'   `Indicator Name` column.
#' @param indicator_info Data frame with `Indicator Name`, `Topic` and
#'   `Definition` columns (see [indicator_info]).
#' @return A `DT::datatable` htmlwidget.
#' @export
#' @examples
#' render_index_table(mfi, indicator_info)
render_index_table <- function(mfi, indicator_info) {
  indicator <- unique(mfi$`Indicator Name`)
  info <- indicator_info[match(indicator, indicator_info$`Indicator Name`), ]
  data <- data.frame(Indicator = indicator, Topic = info$Topic, Definition = info$Definition)
  result <- DT::datatable(data,
                          options = list(paging = FALSE, autoWidth = FALSE,
                                         columnDefs = list(list(width = "20%", targets = 1),
                                                           list(width = "10%", targets = 2))))
  # DT::formatStyle(result, "Topic", fontSize = "80%", lineHeight = "1")
  # DT::formatStyle(result, "Definition", fontSize = "80%", lineHeight = "1")
  result
}
