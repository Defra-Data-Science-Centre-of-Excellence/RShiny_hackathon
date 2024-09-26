# Functions that will be used in the app

# scatter chart for bill vs flipper length
bill_flipper_plot <- function(data){
  
  # create plot
  fig <- plot_ly(
    data = data,
    x = ~bill_length_mm,
    y = ~flipper_length_mm,
    color = ~species,
    colors = c("#12436D", "#28A197", "#801650"),
    type = "scatter",
    text = ~species,
    mode = "markers",
    # set the text to display in the hover over
    hovertemplate = paste0(
      "<b>%{text}</b><br>",
      "%{xaxis.title.text}: %{x}<br>",
      "%{yaxis.title.text}: %{y}",
      "<extra></extra>"
    )
  ) %>% 
    layout(
      xaxis = list(title = "Bill length (mm)",
                   range = c(25, 70),
                   showgrid = FALSE),
      yaxis = list(title = "Flipper length (mm)",
                   range = c(155, 240)),
      legend = list(title = list(text = "<b>Species</b>"))
    )
  
  return(fig)
  
}
