# load packages
library(shiny)
library(plotly)
library(dplyr)
library(DT)
source("R/get_data.R")
source("R/utils.R")

# Define UI - the UI (user interface) controls the layout and appearance 
# of your app (the front end)
ui <- fluidPage(
  
  # add styling to the app using a css stylesheet
  includeCSS("www/styles.css"),
  
  # create navigation bar for page
  navbarPage(
    # Title of whole app
    "Penguins",
    
    # first page tab called Adelie
    tabPanel("Adelie",
             # side bar for user input
             sidebarLayout(
               sidebarPanel(
                 # dropdown to choose the year, populated by the years in the dataset:
                 # the first argument here "year" is the id, which is how we will 
                 # reference this input in the server function
                 # the label just gives a title above the dropdown
                 # the choices are what will be listed in the dropdown, so we 
                 # give it the list of years in the dataset
                 selectInput(
                   "year", label = "Year", choices = unique(data$year)
                 )),

               # main panel to display outputs
               mainPanel(
                 # output - display this in tabset panels
                 tabsetPanel(
                   # the first tab will have the title "Plot" and display 
                   # a plotly chart
                   tabPanel("Plot", plotlyOutput("plot")),
                   # the second tab will have the title "Data Table" and display
                   # a data table
                   tabPanel("Data Table", dataTableOutput("table"))
                 ))
             )),

    # second tab called Gentoo
    tabPanel("Gentoo", 
             "second page"
             ),

    # third tab called Chinstrap
    tabPanel("Chinstrap", 
             "third page"
             )

  ))

# Define server - this contains the instructions needed to build the app (the back end)
server <- function(input, output) {
  
  # set the year for the whole page based on what is selected in the dropdown
  # this makes selected_year a reactive expression
  # so from here we reference it like a function as selected_year()
  # the input$year comes from the id we set in the ui function
  selected_year <- reactive({
    input$year
  })

  # generate a plot of the data for selected year
  # output$plot because we set the plotly output id to "plot" in the ui function
  output$plot <- renderPlotly({

    # filter data to the selected year
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
