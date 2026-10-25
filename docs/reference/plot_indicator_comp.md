# Build an indicator comparison line chart

Plots several indicators' values over time, for a single country, as one
line per indicator. Rows with missing values for the given filters are
dropped before plotting.

## Usage

``` r
plot_indicator_comp(mfi, country, indicators, font_style)
```

## Arguments

- mfi:

  Data frame of World Bank indicator values (long format, with
  `Country Name`, `Indicator Name`, `Year`, `value` columns).

- country:

  Character. Country name to plot.

- indicators:

  Character vector of indicator names to plot.

- font_style:

  A `plotly` font list (e.g. `list(size = 20, color = "gray25")`)
  applied to the chart's layout.

## Value

A `plotly` htmlwidget.

## Examples

``` r
plot_indicator_comp(
  mfi,
  country = "Greece",
  indicators = c("Population, female", "Population, male"),
  font_style = font_style
)

{"x":{"visdat":{"15444c17f9d":["function () ","plotlyVisDat"]},"cur_data":"15444c17f9d","attrs":{"15444c17f9d":{"x":{},"y":{},"mode":"lines+markers","showlegend":true,"color":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"scatter"}},"layout":{"margin":{"b":250,"l":50,"t":100,"r":50,"pad":0},"autosize":true,"legend":{"orientation":"h","xanchor":"center","x":0.5,"y":1},"title":"Country: Greece","xaxis":{"domain":[0,1],"automargin":true,"title":"Year","tickangle":-90,"type":"category","categoryorder":"array","categoryarray":["1960","1961","1962","1963","1964","1965","1966","1967","1968","1969","1970","1971","1972","1973","1974","1975","1976","1977","1978","1979","1980","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025"]},"yaxis":{"domain":[0,1],"automargin":true,"title":""},"showlegend":true,"font":{"size":20,"color":"gray25","weight":"bold"},"hovermode":"closest"},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false,"responsive":true},"data":[{"x":["1960","1961","1962","1963","1964","1965","1966","1967","1968","1969","1970","1971","1972","1973","1974","1975","1976","1977","1978","1979","1980","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025"],"y":[4243998,4277322,4303245,4319420,4335508,4370132,4425256,4458165,4485019,4503102,4500065,4514003,4543153,4562652,4578411,4620203,4693735,4757368,4817689,4861113,4898647,4947852,4978327,5007196,5031896,5051239,5067817,5084876,5103629,5130612,5185788,5247847,5285766,5314499,5338815,5361399,5383172,5407996,5435765,5454395,5474870,5501833,5521522,5535747,5551573,5570703,5592530,5614075,5637262,5660762,5677254,5680238,5665118,5641796,5619195,5593702,5573396,5559688,5544756,5530964,5513797,5449170,5382617,5366507,5365010,5367892],"mode":"lines+markers","showlegend":true,"type":"scatter","name":"Population, female","marker":{"color":"rgba(102,194,165,1)","line":{"color":"rgba(102,194,165,1)"}},"textfont":{"color":"rgba(102,194,165,1)"},"error_y":{"color":"rgba(102,194,165,1)"},"error_x":{"color":"rgba(102,194,165,1)"},"line":{"color":"rgba(102,194,165,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":["1960","1961","1962","1963","1964","1965","1966","1967","1968","1969","1970","1971","1972","1973","1974","1975","1976","1977","1978","1979","1980","1981","1982","1983","1984","1985","1986","1987","1988","1989","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025"],"y":[4087727,4120728,4144988,4160205,4174921,4180201,4188395,4225923,4255746,4269662,4292741,4317033,4345475,4366434,4383611,4426338,4494415,4551111,4612270,4687145,4743858,4781498,4811186,4839431,4863905,4883061,4899396,4915719,4933354,4958886,5011004,5072080,5113295,5145916,5174107,5200754,5225628,5253263,5284744,5307303,5330938,5360299,5380500,5392323,5403568,5416611,5427832,5434398,5440579,5446255,5444087,5424661,5379893,5323415,5273218,5227181,5202575,5194991,5188126,5190618,5184802,5120960,5055188,5040844,5040124,5046070],"mode":"lines+markers","showlegend":true,"type":"scatter","name":"Population, male","marker":{"color":"rgba(141,160,203,1)","line":{"color":"rgba(141,160,203,1)"}},"textfont":{"color":"rgba(141,160,203,1)"},"error_y":{"color":"rgba(141,160,203,1)"},"error_x":{"color":"rgba(141,160,203,1)"},"line":{"color":"rgba(141,160,203,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
```
