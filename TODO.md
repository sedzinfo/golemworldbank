# TODO

Loose ends found while documenting the package (October 2026). None of them breaks
the app; they are listed from most to least useful.

## Scatterplot leaves out 17 countries

`plot_cor()` ([R/fct_plots.R](R/fct_plots.R), lines 344-352) finds the region of a
country by matching its `Country Name` in `mfi` to its `Short Name` in `country_code`.
For 17 countries the two names differ, so they get no region and never appear on the
Scatterplot tab:

| Code | Name in `mfi`             | `Short Name` in `country_code`         |
|------|---------------------------|----------------------------------------|
| BOL  | Bolivia                   | Bolivia, Plurinational State of        |
| CIV  | Cote d'Ivoire             | Côte d'Ivoire                          |
| COD  | Congo, Dem. Rep.          | Congo, Democratic Republic of          |
| COG  | Congo, Rep.               | Congo, Republic of                     |
| CUW  | Curacao                   | Curaçao                                |
| EGY  | Egypt, Arab Rep.          | Egypt, Arab Republic of                |
| FSM  | Micronesia, Fed. Sts.     | Micronesia, Federated States of        |
| IRN  | Iran, Islamic Rep.        | Iran, Islamic Republic of              |
| KOR  | Korea, Rep.               | Korea                                  |
| NRU  | Naoero                    | Nauru                                  |
| PRK  | Korea, Dem. People's Rep. | Korea, Democratic People's Republic of |
| SOM  | Somalia, Fed. Rep.        | Somalia                                |
| STP  | Sao Tome and Principe     | São Tomé and Principe                  |
| TUR  | Turkiye                   | Türkiye                                |
| VEN  | Venezuela, RB             | Venezuela, República Bolivariana de    |
| VIR  | Virgin Islands (U.S.)     | Virgin Islands (US)                    |
| YEM  | Yemen, Rep.               | Yemen, Republic of                     |

All 17 have a region under their `Country Code`, so the fix is to match on the code:
keep `Country Code` in the `reshape()` (`idvar = c("Country Code", "Country Name", "Year")`)
and merge with `by = "Country Code"`. After the fix, update the description of
`plot_cor()`, which documents the current behavior.

## Code that never runs

- **`input$dimension` observer** ([R/app_server.R](R/app_server.R), lines 17-30): left
  from an earlier version. No script in the page sends `input$dimension` or handles the
  `scaleUI` message. Delete it, or add the JavaScript if the scaling is still wanted.
- **`year_max` in `plot_bar()`** ([R/fct_plots.R](R/fct_plots.R), lines 248-254): it is
  computed for a value axis that only grows, but the code that would use it is
  commented out. Either bring that code back (and mention it in the description of
  `plot_bar()` again) or delete both.
- **`format_bignum()`** ([R/utils_helpers.R](R/utils_helpers.R), line 46): exported, but
  the app does not use it. The charts use the internal `format_value()`. Keep it as a
  user-facing helper, or remove it and its man page.
- **Picker options** ([R/mod_country_comp.R](R/mod_country_comp.R) and
  [R/mod_indicator_comp.R](R/mod_indicator_comp.R), line 22): `actions-box`,
  `live-search` and `selected-text-format` are options of bootstrap-select
  (`shinyWidgets::pickerInput()`), not of `selectizeInput()`, which ignores them.
  Remove them, or switch to `pickerInput()` if the select-all buttons are wanted.

## Dark mode

- **Green numbers in Change (%)** ([R/fct_change.R](R/fct_change.R), line 119): the dark
  green of an increase (`#1E7B34`) is dim on the dark background. DT writes the color
  into each cell, which `dark_mode.css` cannot easily override. Use a green that reads on
  both backgrounds, or set the color with a CSS class instead.
