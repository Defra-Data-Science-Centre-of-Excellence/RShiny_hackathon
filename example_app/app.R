# load packages
library(shiny)
library(plotly)
library(dplyr)
library(DT)
source("get_data.R")
source("utils.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # create navigation bar for page
  navbarPage(
    # Title of whole app
    "Penguins",
    
    # first page tab called Adelie
    tabPanel("Adelie",
             # side bar for user input
             sidebarLayout(
               sidebarPanel(
                 # dropdown to choose the year, populated by the years in the dataset
                 selectInput(
                   "year", label = "Year", choices = unique(adelie$year)
                 )),
               
               # main panel to display outputs
               mainPanel(
                 # output - tabset with plot and table
                 tabsetPanel(
                   tabPanel("Plot", plotlyOutput("plot")),
                   tabPanel("Table", dataTableOutput("table"))
                 ))
             )),
    
    # second tab called Gentoo
    tabPanel("Gentoo", "second page"),
    
    # third tab called Chinstrap
    tabPanel("Chinstrap", "third page")
    
  ))

# Define server logic required to draw a histogram
server <- function(input, output) {
  # set the year for the whole page based on what is selected in the dropdown
  # this makes selected_year a reactive expression, so from here we reference it like a function as selected_year()
  selected_year <- reactive({
    input$year
  })
  
  # generate a plot of the data for selected year
  output$plot <- renderPlotly({

    # filter to the selected year
    plot_data <- data %>% filter(year == selected_year())
    
    # create plotly plot
    plot_data %>%
      bill_flipper_plot(species = "Adelie")
    
  })
  
  # generate a table of the data for the selected year
  # using the DT package renderDataTable to get an interactive table
  output$table <- renderDataTable({
    
    # filter to selected year and relevant columns
    table_data <- data %>% 
      filter(year == selected_year() & species == "Adelie") %>% 
      select(species, island, bill_length_mm, flipper_length_mm)
    
    # create table
    datatable(table_data)
    
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)
