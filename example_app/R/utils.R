# Functions that will be used in the app
library(afcolours)

# scatter chart for bill vs flipper length
bill_flipper_plot <- function(data, species){
  
  # filter data to selected species
  plot_data <- data %>% filter(species == species)
  
  # create plot
  fig <- plot_ly(
    data = plot_data,
    x = ~bill_length_mm,
    y = ~flipper_length_mm,
    color = ~island,
    # use the analysis function colour palette
    colors = c(af_colours(type = "categorical", n = 3)),
    type = "scatter",
    text = ~island,
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
      legend = list(title = list(text = "<b>Island</b>"))
    )
  
  return(fig)
  
}
