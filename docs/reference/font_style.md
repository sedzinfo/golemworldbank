# Font of the charts

The font of every chart of the app: 20 px, bold, dark gray. The app
passes it as the `font_style` argument of the `plot_*()` functions,
which give it to `plotly::layout(font = )`, so that all the charts share
one look.

## Usage

``` r
font_style
```

## Format

A list with the elements `size`, `color` and `weight`.

## Examples

``` r
plotly::layout(plotly::plot_ly(), font = font_style)

{"x":{"visdat":{"d76c2bf53f3f":["function () ","plotlyVisDat"]},"cur_data":"d76c2bf53f3f","attrs":{"d76c2bf53f3f":{"alpha_stroke":1,"sizes":[10,100],"spans":[1,20]}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"font":{"size":20,"color":"gray25","weight":"bold"},"xaxis":{"domain":[0,1],"automargin":true},"yaxis":{"domain":[0,1],"automargin":true},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"type":"scatter","mode":"markers","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(31,119,180,1)"}},"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"line":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
```
