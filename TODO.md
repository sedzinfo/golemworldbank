# TODO

## Code that never runs

- **`year_max` in `plot_bar()`** ([R/fct_plots.R](R/fct_plots.R), lines 248-254): it is
  computed for a value axis that only grows, but the code that would use it is
  commented out. Either bring that code back (and mention it in the description of
  `plot_bar()` again) or delete both.
- **`format_bignum()`** ([R/utils_helpers.R](R/utils_helpers.R), line 46): exported, but
  the app does not use it. The charts use the internal `format_value()`. Keep it as a
  user-facing helper, or remove it and its man page.

## Dark mode

- **Green numbers in Change (%)** ([R/fct_change.R](R/fct_change.R), line 119): the dark
  green of an increase (`#1E7B34`) is dim on the dark background. DT writes the color
  into each cell, which `dark_mode.css` cannot easily override. Use a green that reads on
  both backgrounds, or set the color with a CSS class instead.
