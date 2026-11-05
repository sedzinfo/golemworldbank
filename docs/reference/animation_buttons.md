# Pause and Stop buttons for an animated plotly chart

Builds the `updatemenus` entry shown next to plotly's own Play button,
used by every animated chart of the app. Pause halts the animation on
the current frame; Stop halts it and jumps back to the first frame.

## Usage

``` r
animation_buttons(first_frame)
```

## Arguments

- first_frame:

  Character. Name of the first animation frame (for these charts, the
  first year).

## Value

A list to pass as `plotly::layout(updatemenus = ...)`.

## Examples

``` r
# an animated chart with one frame per year
d <- data.frame(x = 1:3, y = c(2, 4, 3), year = c("1960", "1961", "1962"))
p <- plotly::plot_ly(d, x = ~x, y = ~y, frame = ~year, type = "scatter", mode = "markers")
plotly::layout(p, updatemenus = animation_buttons("1960"))

{"x":{"visdat":{"dbae38b488e1":["function () ","plotlyVisDat"]},"cur_data":"dbae38b488e1","attrs":{"dbae38b488e1":{"x":{},"y":{},"mode":"markers","frame":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"scatter"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"updatemenus":[{"type":"buttons","direction":"right","x":0,"y":0,"showactive":false,"buttons":[{"label":"Pause","method":"animate","args":[[[]],{"mode":"immediate","frame":{"duration":0,"redraw":true},"transition":{"duration":0}}]},{"label":"Stop","method":"animate","args":[["1960"],{"mode":"immediate","frame":{"duration":0,"redraw":true},"transition":{"duration":0}}]}]},{"type":"buttons","direction":"right","showactive":false,"y":0,"x":0,"yanchor":"top","xanchor":"right","pad":{"t":60,"r":5},"buttons":[{"label":"Play","method":"animate","args":[null,{"fromcurrent":true,"mode":"immediate","transition":{"duration":500,"easing":"linear"},"frame":{"duration":500,"redraw":false}}]}]}],"xaxis":{"domain":[0,1],"automargin":true,"title":"x","range":[0.90000000000000002,3.1000000000000001]},"yaxis":{"domain":[0,1],"automargin":true,"title":"y","range":[1.8999999999999999,4.0999999999999996]},"hovermode":"closest","showlegend":true,"sliders":[{"currentvalue":{"prefix":"year: ","xanchor":"right","font":{"size":16,"color":"rgba(204,204,204,1)"}},"steps":[{"method":"animate","args":[["1960"],{"transition":{"duration":500,"easing":"linear"},"frame":{"duration":500,"redraw":false},"mode":"immediate"}],"label":"1960","value":"1960"},{"method":"animate","args":[["1961"],{"transition":{"duration":500,"easing":"linear"},"frame":{"duration":500,"redraw":false},"mode":"immediate"}],"label":"1961","value":"1961"},{"method":"animate","args":[["1962"],{"transition":{"duration":500,"easing":"linear"},"frame":{"duration":500,"redraw":false},"mode":"immediate"}],"label":"1962","value":"1962"}],"visible":true,"pad":{"t":40}}]},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":[1],"y":[2],"mode":"markers","frame":"1960","type":"scatter","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(31,119,180,1)"}},"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"line":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","visible":true}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"frames":[{"name":"1960","data":[{"x":[1],"y":[2],"mode":"markers","frame":"1960","type":"scatter","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(31,119,180,1)"}},"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"line":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","visible":true}],"traces":[0]},{"name":"1961","data":[{"x":[2],"y":[4],"mode":"markers","frame":"1961","type":"scatter","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(31,119,180,1)"}},"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"line":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","visible":true}],"traces":[0]},{"name":"1962","data":[{"x":[3],"y":[3],"mode":"markers","frame":"1962","type":"scatter","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(31,119,180,1)"}},"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"line":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","visible":true}],"traces":[0]}],"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
```
