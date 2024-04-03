# Functions that will be used in the app

# scatter chart for bill vs flipper length
bill_flipper_plot <- function(data, species){
  
  plot_data <- data %>% filter(species == species)
  
  fig <- plot_ly(
    data = plot_data,
    x = ~bill_length_mm,
    y = ~flipper_length_mm,
    color = ~island,
    type = "scatter",
    text = ~island,
    mode = "markers",
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
                   range = c(155, 240))
    )
  
  return(fig)
  
}
