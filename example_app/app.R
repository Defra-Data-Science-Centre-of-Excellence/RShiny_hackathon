# load packages
library(shiny)
library(plotly)
library(dplyr)
source("get_data.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # create navigation bar for page
  navbarPage(
    # Title of whole app
    "Penguins",
    
    # first page tab called Flippers
    tabPanel("Flippers",
             # side bar for user input
             sidebarLayout(
               sidebarPanel(
                 # dropdown to choose the year, populated by the years in the dataset
                 selectInput(
                   "year", label = "Year", choices = unique(flipper_length$year)
                 )),
               
               # main panel to display outputs
               mainPanel(
                 # output - tabset with plot and table
                 tabsetPanel(
                   tabPanel("Plot", plotOutput("plot")),
                   tabPanel("Table", tableOutput("table"))
                 ))
             )),
    
    # second tab called Bills
    tabPanel("Bills", "second page")
    
  ))

# Define server logic required to draw a histogram
server <- function(input, output) {
  # set the year for the whole page based on what is selected in the dropdown
  selected_year <- reactive({
    input$year
  })
  
  # generate a plot of the data for selected year
  output$plot <- renderPlot({
    ggplot(
      flipper_length %>%
        filter(year == selected_year()),
      aes(x = species, y = mean_flipper_mm)
    ) +
      geom_bar(stat = "identity") +
      labs(x = "Species", y = "Average flipper length (mm)")
  })
  
  # generate a table of the data for the selected year
  output$table <- renderTable({
    flipper_length %>%
      filter(year == selected_year()) %>%
      select(!year)
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)
