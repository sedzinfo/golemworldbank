# TODO

## Code that never runs

- **`year_max` in
  [`plot_bar()`](https://sedzinfo.github.io/golemworldbank/reference/plot_bar.md)**
  ([R/fct_plots.R](https://sedzinfo.github.io/golemworldbank/R/fct_plots.R),
  lines 248-254): it is computed for a value axis that only grows, but
  the code that would use it is commented out. Either bring that code
  back (and mention it in the description of
  [`plot_bar()`](https://sedzinfo.github.io/golemworldbank/reference/plot_bar.md)
  again) or delete both.
- **`format_bignum()`**
  ([R/utils_helpers.R](https://sedzinfo.github.io/golemworldbank/R/utils_helpers.R),
  line 46): exported, but the app does not use it. The charts use the
  internal
  [`format_value()`](https://sedzinfo.github.io/golemworldbank/reference/format_value.md).
  Keep it as a user-facing helper, or remove it and its man page.

## Dark mode

- **Green numbers in Change (%)**
  ([R/fct_change.R](https://sedzinfo.github.io/golemworldbank/R/fct_change.R),
  line 119): the dark green of an increase (`#1E7B34`) is dim on the
  dark background. DT writes the color into each cell, which
  `dark_mode.css` cannot easily override. Use a green that reads on both
  backgrounds, or set the color with a CSS class instead.
